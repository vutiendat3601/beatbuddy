package vn.io.datvutech.beatbuddy.search;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

import vn.io.datvutech.beatbuddy.search.dto.TrackDto;
import vn.io.datvutech.beatbuddy.search.service.SearchService;

@SpringBootApplication
public class SearchServiceApplication {
	public static void main(String[] args) {
		ApplicationContext ctx = SpringApplication.run(SearchServiceApplication.class, args);
		SearchService searchService = ctx.getBean(SearchService.class);
		searchService.createTrack(new TrackDto());
	}
}
