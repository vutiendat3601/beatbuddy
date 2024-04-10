package vn.io.datvutech.beatbuddy.search.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public abstract class AbstractCatalog {
    private Long totalViews = 0L;

    private Long totalLikes = 0L;

    private Long totalShares = 0L;
}
