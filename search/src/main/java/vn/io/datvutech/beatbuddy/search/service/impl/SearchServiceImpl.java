package vn.io.datvutech.beatbuddy.search.service.impl;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import vn.io.datvutech.beatbuddy.search.dto.TrackDto;
import vn.io.datvutech.beatbuddy.search.entity.Track;
import vn.io.datvutech.beatbuddy.search.mapper.TrackMapper;
import vn.io.datvutech.beatbuddy.search.repository.TrackRepository;
import vn.io.datvutech.beatbuddy.search.service.SearchService;

@RequiredArgsConstructor
@Service
public class SearchServiceImpl implements SearchService {
    private final TrackRepository trackRepo;

    @Override
    public void createTrack(TrackDto trackDto) {
        Track track = TrackMapper.mapToTrack(trackDto, new Track());
        trackRepo.save(track);
    }
}
