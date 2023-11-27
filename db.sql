CREATE DATABASE joy_of_painting_series;
USE joy_of_painting_series;

/* create tables */
CREATE TABLE episodes (
    episode_id INT PRIMARY KEY,
    title VARCHAR (255) NOT NULL,
    air_date VARCHAR (255) NOT NULL,
    episode_number INT NOT NULL,
    season_number INT NOT NULL,
    painting_img_src VARCHAR(255) NOT NULL,
    painting_yt_src VARCHAR(255) NOT NULL
);

CREATE TABLE colors (
    color_id INT PRIMARY KEY,
    color_name VARCHAR(255) NOT NULL
);

CREATE TABLE subject_matters(
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(255) NOT NULL
);

/* create join tables: episode_colors, episode_subject_matters */
CREATE TABLE episode_colors (
    episode_color_id INT PRIMARY KEY,
    episode_id INT NOT NULL,
    color_id INT NOT NULL,
    FOREIGN KEY (episode_id) REFERENCES episodes(episode_id),
    FOREIGN KEY (color_id) REFERENCES colors(color_id)
);

CREATE TABLE episode_subject_matters (
    episode_subject_matter_id INT PRIMARY KEY,
    episode_id INT NOT NULL,
    subject_matter_id INT NOT NULL,
    FOREIGN KEY (episode_id) REFERENCES episodes(episode_id),
    FOREIGN KEY (subject_matter_id) REFERENCES subject_matters(subject_matter_id)
);