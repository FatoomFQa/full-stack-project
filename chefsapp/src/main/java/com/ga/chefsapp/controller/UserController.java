package com.ga.chefsapp.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.ga.chefsapp.dao.RateDao;
import com.ga.chefsapp.dao.RecipeDao;
import com.ga.chefsapp.dao.UserDao;
import com.ga.chefsapp.model.Recipe;
import com.ga.chefsapp.helpers.ZXingHelper;
import com.ga.chefsapp.model.User;

@Controller
public class UserController {

	@Autowired
	UserDao userDao;

	@Autowired
	RecipeDao recipeDao;

	@Autowired
	private Environment env;

	@Autowired
	HttpServletRequest request;

	@Autowired
	private RateDao rateDao;

	// HTTP GET Request - Get Sign up
	@GetMapping("/user/signup")
	public ModelAndView signup() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("user/signup");
		HomeController hc = new HomeController();
		hc.setAppName(mv, env);
		return mv;
	}

	// HTTP POST Request - Register user
	@PostMapping("/user/signup")
	public ModelAndView signup(User user) {
		ModelAndView mv = new ModelAndView();

		HomeController hc = new HomeController();
		hc.setAppName(mv, env);

		var it = userDao.findAll();
		for (User dbUser : it) {
			if (dbUser.getEmailAddress().equals(user.getEmailAddress())) {
				mv.setViewName("user/signup");
				mv.addObject("signupFailMessage", "Email address is already exists");
				return mv;
			}
		}
		mv.addObject("signupSuccessMessage", "Your registeration has been successfully completed! Please login");
		mv.setViewName("user/login");

		// password Encryption
		BCryptPasswordEncoder bCrypt = new BCryptPasswordEncoder();
		String newPassword = bCrypt.encode(user.getPassword());
		user.setPassword(newPassword);

		userDao.save(user);
		return mv;
	}

	// HTTP GET Request - Get Login
	@GetMapping("/user/login")
	public ModelAndView login() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("user/login");

		HomeController hc = new HomeController();
		hc.setAppName(mv, env);
		return mv;
	}

	// HTTP GET Request - Get user profile
	@GetMapping("/user/detail")
	public ModelAndView userDetails(@RequestParam String email) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("user/detail");

		HomeController hc = new HomeController();
		hc.setAppName(mv, env);

		User user = userDao.findByEmailAddress(email);
		var recipes = recipeDao.findAllByUser(user);
		int count = recipeDao.countByUser(user);

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();

		boolean flag = false;
		if (username.equals(user.getEmailAddress())) {
			flag = true;
		}
		ArrayList<Integer> ratelist = new ArrayList<>();
		for (Recipe recipe : recipes) {
			if (rateDao.findByRecipeAvg(recipe) != null) {
				ratelist.add(rateDao.findByRecipeAvg(recipe));
			} else {
				ratelist.add(0);
			}
		}
		var rateIt = Arrays.asList(ratelist);
		mv.addObject("rates", rateIt);
		mv.addObject("recipes", recipes);
		mv.addObject("count", count);
		mv.addObject("flag", flag);
		mv.addObject("user", user);

		return mv;
	}

	// HTTP GET Request - Get chefs index
	@GetMapping("/chefs/index")
	public ModelAndView loadChefs() {

		ModelAndView mv = new ModelAndView();
		List<Object[]> chefs = userDao.findByFKuserId();

		mv.setViewName("chefs/index");
		mv.addObject("chefs", chefs);

		HomeController hc = new HomeController();
		hc.setAppName(mv, env);

		return mv;
	}

	// HTTP POST Request - Edit user info
	@PostMapping("/user/edit")
	public String userEdit(User user) {
		BCryptPasswordEncoder bCrypt = new BCryptPasswordEncoder();
		String newPassword = bCrypt.encode(user.getPassword());
		user.setPassword(newPassword);
		userDao.save(user);
		return "redirect:/user/detail?email=" + user.getEmailAddress();
	}

	// HTTP GET Request - Delete user
	@GetMapping("/chefs/delete")
	public String userDelete(@RequestParam int id) {
		userDao.deleteById(id);
		return "redirect:/chefs/index";
	}

	// HTTP GET Request - Get QR Code
	@GetMapping("/user/detail/qrcode")
	public void qrcode(@RequestParam String email, HttpServletResponse response) throws Exception {
		String appName = env.getProperty("app.name");
		response.setContentType("image/png");
		OutputStream outputStream = response.getOutputStream();
		outputStream.write(ZXingHelper.getQRCode(appName + "user/detail?email=" + email, 200, 200));
		outputStream.flush();
		outputStream.close();
	}

	// HTTP GET Request - Download QR Code
	@GetMapping("/user/detail/qrcode/download")
	public String downloadQRCode(@RequestParam String email, HttpServletResponse response)
			throws MalformedURLException {
		// String appName = env.getProperty("app.name");
		User user = userDao.findByEmailAddress(email);
		String fileName = "Chef " + user.getFirstName() + " " + user.getLastName();
		final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
		System.out.println("url: " + baseUrl);

		File downdloadDirDir = new File(System.getProperty("user.home"), "Downloads");
		String pathToDownloads = downdloadDirDir.getPath();
		HttpSession session = request.getSession();

		try {
			URL url = new URL(baseUrl + "/user/detail/qrcode?email=" + email);
			HttpURLConnection http = (HttpURLConnection) url.openConnection();
			BufferedInputStream in = new BufferedInputStream(http.getInputStream());
			FileOutputStream fileOut = new FileOutputStream(
					new File(pathToDownloads + System.getProperty("file.separator") + fileName + ".png"));
			BufferedOutputStream out = new BufferedOutputStream(fileOut, 1024);
			byte[] buffer = new byte[1024];
			int read = 0;
			while ((read = in.read(buffer, 0, 1024)) >= 0) {
				out.write(buffer, 0, read);
			}
			out.close();
			in.close();
			session.setAttribute("downloadSuccssMessage",
					"QR code downloaded succssfully, find it in your downloads folder!");

			return "redirect:/user/detail?email=" + user.getEmailAddress();
		} catch (IOException e) {
			e.printStackTrace();
			session.setAttribute("downloadFailMessage", "QR code download failed");

			return "redirect:/user/detail?email=" + user.getEmailAddress();
		}
	}
}
