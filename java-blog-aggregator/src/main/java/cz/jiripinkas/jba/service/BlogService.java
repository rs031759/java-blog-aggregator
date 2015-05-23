package cz.jiripinkas.jba.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.access.method.P;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;

import cz.jiripinkas.jba.entity.Blog;
import cz.jiripinkas.jba.entity.Item;
import cz.jiripinkas.jba.entity.User;
import cz.jiripinkas.jba.exception.RssException;
import cz.jiripinkas.jba.repository.BlogRepository;
import cz.jiripinkas.jba.repository.ItemRepository;
import cz.jiripinkas.jba.repository.UserRepository;

@Service
public class BlogService {
	@Autowired
	private BlogRepository blogRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private RssService rssService;
	
	@Autowired
	private ItemRepository itemRepository;
	
	
	public void saveItems(Blog blog) {
		try {
			
			//*  I can't make it to work if it reads from url
			//* I will try using the file
			List<Item> items = rssService.getItems(blog.getUrl());
			
			//List<Item> items = rssService.getItems(new File("/test-rss/javavids.xml"));
		
			for (Item item : items) {
			 Item savedItem = itemRepository.findByBlogAndLink(blog, item.getLink());
				
			 	if(savedItem == null) {
					item.setBlog(blog);
			 		itemRepository.save(item);
			 	}
			}
		} catch (RssException e) {
			e.printStackTrace();
		}
	}
	
	// one hour in milliseconds = 60* 60 * 10000
	@Scheduled(fixedDelay=3600000)
	public void reloadBlogs() {
		List<Blog> blogs = blogRepository.findAll();
		for (Blog blog : blogs) {
			saveItems(blog);
		}
	}
	
	public void save(Blog blog, String name) {
		User user = userRepository.findByName(name);
		blog.setUser(user);
		blogRepository.save(blog);
		saveItems(blog);
	}

	public String delete(int id) {
		 blogRepository.delete(id);
		 return "redirect:/account.html";
	}
	
	@PreAuthorize("#blog.user.name == authentication.name or hasRole('ROLE_ADMIN')")
	public void delete(@P("blog") Blog blog) {
		blogRepository.delete(blog);
	  
}

	public Blog findOne(int id) {
		return blogRepository.findOne(id);
	}
}
