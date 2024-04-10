package vn.io.datvutech.beatbuddy.search.mapper;

import vn.io.datvutech.beatbuddy.search.dto.TrackDto;
import vn.io.datvutech.beatbuddy.search.entity.Track;

public class TrackMapper {
    public static TrackDto mapToTrackDto(Track track, TrackDto trackDto) {
        trackDto.setId(track.getId());
        trackDto.setUrn(track.getUrn());
        trackDto.setName(track.getName());
        trackDto.setDurationSec(track.getDurationSec());
        trackDto.setDescription(track.getDescription());
        trackDto.setReleasedDate(track.getReleasedDate());
        trackDto.setThumbnail(track.getThumbnail());
        trackDto.setIsPublic(track.getIsPublic());
        trackDto.setIsPlayable(track.getIsPlayable());
        trackDto.setTotalViews(track.getTotalViews());
        trackDto.setTotalLikes(track.getTotalLikes());
        trackDto.setTotalShares(track.getTotalShares());
        trackDto.setTotalListens(track.getTotalListens());
        return trackDto;
    }

    public static Track mapToTrack(TrackDto trackDto, Track track) {
        track.setId(trackDto.getId());
        track.setUrn(trackDto.getUrn());
        track.setName(trackDto.getName());
        track.setDurationSec(trackDto.getDurationSec());
        track.setDescription(trackDto.getDescription());
        track.setReleasedDate(trackDto.getReleasedDate());
        track.setThumbnail(trackDto.getThumbnail());
        track.setIsPublic(trackDto.getIsPublic());
        track.setIsPlayable(trackDto.getIsPlayable());
        track.setTotalViews(trackDto.getTotalViews());
        track.setTotalLikes(trackDto.getTotalLikes());
        track.setTotalShares(trackDto.getTotalShares());
        track.setTotalListens(trackDto.getTotalListens());
        return track;
    }
}
