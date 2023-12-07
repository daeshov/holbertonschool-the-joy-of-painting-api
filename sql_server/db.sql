CREATE DATABASE joy_of_painting_api;

-- Create episodes table
CREATE TABLE episodes (
    episode_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    air_date TEXT NOT NULL,
    episode_number INTEGER NOT NULL,
    season_number INTEGER NOT NULL,
    painting_img_src TEXT NOT NULL,
    painting_yt_src TEXT NOT NULL
);

-- Create colors table
CREATE TABLE colors (
    color_id INTEGER PRIMARY KEY,
    color_name TEXT NOT NULL
);

-- Create subject_matters table
CREATE TABLE subject_matters (
    subject_id INTEGER PRIMARY KEY,
    subject_name TEXT NOT NULL
);

-- Create episode_colors table
CREATE TABLE episode_colors (
    episode_color_id INTEGER PRIMARY KEY,
    episode_id INTEGER NOT NULL,
    color_id INTEGER NOT NULL,
    FOREIGN KEY (episode_id) REFERENCES episodes(episode_id),
    FOREIGN KEY (color_id) REFERENCES colors(color_id)
);

-- Create episode_subject_matters table
CREATE TABLE episode_subject_matters (
    episode_subject_matter_id INTEGER PRIMARY KEY,
    episode_id INTEGER NOT NULL,
    subject_matter_id INTEGER NOT NULL,
    FOREIGN KEY (episode_id) REFERENCES episodes(episode_id),
    FOREIGN KEY (subject_matter_id) REFERENCES subject_matters(subject_id)
);
