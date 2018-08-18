CREATE TABLE articles
(
    id          INT AUTO_INCREMENT
PRIMARY KEY,
    title       TEXT                                NULL,
    theme       TEXT                                NULL,
    description TEXT                                NULL,
    cover_img   TEXT                                NULL,
    content     LONGTEXT                                NULL,
    time        TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP
)
ENGINE = InnoDB
CHARSET = utf8;