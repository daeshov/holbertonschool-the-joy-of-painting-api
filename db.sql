CREATE DATABASE  IF NOT EXISTS joy_of_painting_series;
USE joy_of_painting_series;

/* create tables */
CREATE TABLE IF NOT EXISTS episodes (
    episode_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    air_date VARCHAR(255) NOT NULL,
    episode_number INT NOT NULL,
    season_number INT NOT NULL,
    painting_img_src VARCHAR(255) NOT NULL,
    painting_yt_src VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS colors (
    color_id INT PRIMARY KEY AUTO_INCREMENT,
    color_name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS subject_matters(
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(255) NOT NULL
);

/* create join tables: episode_colors, episode_subject_matters */
CREATE TABLE IF NOT EXISTS episode_colors (
    episode_color_id INT PRIMARY KEY AUTO_INCREMENT,
    episode_id INT NOT NULL,
    color_id INT NOT NULL,
    FOREIGN KEY (episode_id) REFERENCES episodes(episode_id),
    FOREIGN KEY (color_id) REFERENCES colors(color_id)
);

CREATE TABLE IF NOT EXISTS episode_subject_matters (
    episode_subject_matter_id INT PRIMARY KEY AUTO_INCREMENT,
    episode_id INT NOT NULL,
    subject_matter_id INT NOT NULL,
    FOREIGN KEY (episode_id) REFERENCES episodes(episode_id),
    FOREIGN KEY (subject_matter_id) REFERENCES subject_matters(subject_matter_id)
);