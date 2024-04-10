package vn.io.datvutech.beatbuddy.search.entity;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Artist extends AbstractCatalog {
    private String id;

    private String urn;

    private String name;

    private Boolean isVerified = false;

    private Boolean isPublic = false;

    private String realName;

    private LocalDate birthDate;

    private String description;

    private String nationality;

    private String biography;

    private String thumbnail;

    private String background;
}
