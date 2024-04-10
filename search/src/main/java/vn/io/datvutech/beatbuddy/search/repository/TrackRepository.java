package vn.io.datvutech.beatbuddy.search.repository;

import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import vn.io.datvutech.beatbuddy.search.entity.Track;

public interface TrackRepository extends ElasticsearchRepository<Track, String> {
}
