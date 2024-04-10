package vn.io.datvutech.beatbuddy.search.service;

import java.io.IOException;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import vn.io.datvutech.beatbuddy.search.dto.TrackDto;

@ActiveProfiles("dev")
@SpringBootTest
public class SearchServiceTest {
    private final SearchService searchService;

    @Autowired
    public SearchServiceTest(SearchService searchService) {
        this.searchService = searchService;
    }

    @Test
    public void testCreateTrack() throws IOException {
        ObjectMapper objMapper = new ObjectMapper();
        List<TrackDto> trackDtos = objMapper.readValue(
                getClass().getResourceAsStream("/tracks.json"),
                new TypeReference<List<TrackDto>>() {
                });
        trackDtos.forEach(t -> searchService.createTrack(t));
    }
}
