package vn.io.datvutech.beatbuddy.search.entity;

import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Document(indexName = "track-index")
public class Track extends AbstractCatalog {
    @Id
    private String id;

    private String urn;

    private String name;

    private Boolean isPublic = false;

    private String description;

    private String releasedDate;

    private Integer durationSec = 0;

    private Boolean isPlayable = false;

    private String thumbnail;

    private Long totalListens = 0L;

    private List<Artist> artists;
}
