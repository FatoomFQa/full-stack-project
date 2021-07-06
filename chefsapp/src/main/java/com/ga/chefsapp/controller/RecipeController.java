package com.ga.chefsapp.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.ga.chefsapp.dao.RateDao;
import com.ga.chefsapp.dao.RecipeDao;
import com.ga.chefsapp.dao.UserDao;
import com.ga.chefsapp.helpers.ZXingHelper;
import com.ga.chefsapp.model.Rate;
import com.ga.chefsapp.model.Recipe;
import com.ga.chefsapp.model.User;

@Controller
public class RecipeController {
	@Autowired
	private RecipeDao dao;
	@Autowired
	private Environment env;
	@Autowired
	private UserDao userDao;
	@Autowired
	private RateDao rateDao;
	@Autowired
	HttpServletRequest request;

// HTTP GET REQUEST - Recipe Add
	@GetMapping("/recipe/add")
	public ModelAndView addRecipe() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("recipe/add");
		HomeController hc = new HomeController();
		hc.setAppName(mv, env);
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String email = authentication.getName();
		User user = userDao.findByEmailAddress(email);
		mv.addObject("userId", user.getUserId());
		return mv;
	}

	// HTTP POST REQUEST - Recipe Add
	@PostMapping("/recipe/add")
	public String addRecipe(Recipe recipe) {
		dao.save(recipe);

		HttpSession session = request.getSession();
		session.setAttribute("addRecipeMessage", "your recipe has been added/edited succssfuly");

		return "redirect:/recipe/index?first=All";

	}

	// HTTP GET REQUEST - Recipe Detail
	@GetMapping("/recipe/detail")
	public ModelAndView recipeDetails(@RequestParam int id) {

		Recipe recipe = dao.findById(id);

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String email = authentication.getName();
		User user = userDao.findByEmailAddress(email);

		boolean flag = true;
		ModelAndView mv = new ModelAndView();

		if (user != null) {
			Rate rate = rateDao.findByUserAndRecipe(user, recipe);
			if (rate == null) {
				flag = false;
			} else {
				flag = true;
			}
			mv.addObject("currentUser", user.getUserId());
		}

		mv.setViewName("recipe/detail");
		mv.addObject("recipe", recipe);
		mv.addObject("rates", recipe.getRates());
		mv.addObject("flag", flag);

		HomeController hc = new HomeController();
		hc.setAppName(mv, env);

		return mv;
	}

	// HTTP POST REQUEST - Add Rate to Recipe
	@PostMapping("/recipe/detail")
	public String addRating(Rate rate) {
		rateDao.save(rate);

		HttpSession session = request.getSession();
		session.setAttribute("addRatingMessage", "your rating has been added succssfuly");

		return "redirect:/recipe/detail?id=" + rate.getRecipe().getId();
	}

	// HTTP GET REQUEST - Recipe Edit
	@GetMapping("/recipe/edit")
	public ModelAndView editRecipe(@RequestParam int id) {

		Recipe recipe = dao.findById(id);
		ModelAndView mv = new ModelAndView();

		mv.setViewName("recipe/edit");
		mv.addObject("recipe", recipe);

		HomeController hc = new HomeController();
		hc.setAppName(mv, env);
		return mv;
	}

	// HTTP GET REQUEST - Recipe Delete
	@GetMapping("/recipe/delete")
	public String deleteRecipe(@RequestParam int id) {
		dao.deleteById(id);
		return "redirect:/recipe/index?first=All";
	}

	// HTTP Get REQUEST - Select Recipe
	@GetMapping("/recipe/index")
	public ModelAndView getRecipe(@RequestParam String first) {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String email = authentication.getName();
		User user = userDao.findByEmailAddress(email);
		// عرفنا
		var recipes = dao.findByOrderedRating();

		if (first.equals("All")) {
			recipes = dao.findByOrderedRating();
		} else {
			recipes = dao.findByTypeParams(first);
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

		ModelAndView mv = new ModelAndView();
		mv.setViewName("recipe/index");
		mv.addObject("recipes", recipes);
		mv.addObject("rates", rateIt);
		mv.addObject("user", user);

		HomeController hc = new HomeController();
		hc.setAppName(mv, env);

		return mv;
	}

	// HTTP Get REQUEST - Get QR Code
	@GetMapping("/recipe/detail/qrcode")
	public void qrcode(@RequestParam int id, HttpServletResponse response) throws Exception {
		String appName = env.getProperty("app.name");

		response.setContentType("image/png");
		OutputStream outputStream = response.getOutputStream();

		outputStream.write(ZXingHelper.getQRCode(appName + "recipe/detail?id=" + id, 200, 200));
		outputStream.flush();
		outputStream.close();
	}

	// HTTP Get REQUEST - Download QR Code
	@GetMapping("/recipe/detail/qrcode/download")
	public String downloadQRCode(@RequestParam int id, HttpServletResponse response) {
		Recipe recipe = dao.findById(id);

		String fileName = recipe.getName() + "Recipe ";
		final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
		File downdloadDirDir = new File(System.getProperty("user.home"), "Downloads");
		String pathToDownloads = downdloadDirDir.getPath();
		HttpSession session = request.getSession();

		try {
			URL url = new URL(baseUrl + "/recipe/detail/qrcode?id=" + id);
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
			return "redirect:/recipe/detail?id=" + recipe.getId();
		} catch (IOException e) {
			e.printStackTrace();
			session.setAttribute("downloadFailMessage", "QR code download failed");

			return "redirect:/recipe/detail?id=" + recipe.getId();
		}
	}
}
