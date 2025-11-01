CREATE TABLE IF NOT EXISTS modules(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  summary TEXT,
  locale TEXT,
  levels JSON,
  roles JSON,
  products JSON,
  subjects JSON,
  url TEXT,
  last_modified TIMESTAMPTZ,
  source_file TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS units(
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    locale TEXT,
    duration_in_minutes INT,
    last_modified TIMESTAMPTZ,
    source_file TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS learning_paths(
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    summary TEXT,
    locale TEXT,
    levels JSON,
    products JSON,
    subjects JSON,
    source_file TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS applied_skills(
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    summary TEXT,
    locale TEXT,
    levels JSON,
    roles JSON,
    products JSON,
    subjects JSON,
    url TEXT,
    last_modified TIMESTAMPTZ,
    source_file TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS certifications(
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    subtitle TEXT,
    url TEXT,
    last_modified TIMESTAMPTZ,
    certification_type TEXT,
    exams JSON,
    levels JSON,
    roles JSON,
    source_file TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS merged_certifications(
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    summary TEXT,
    url TEXT,
    last_modified TIMESTAMPTZ,
    certification_type TEXT,
    products JSON,
    levels JSON,
    roles JSON,
    subjects JSON,
    prerequisites JSON,
    skills JSON,
    providers JSON,
    career_paths JSON,
    source_file TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS exams(
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    subtitle TEXT,
    url TEXT,
    last_modified TIMESTAMPTZ,
    levels JSON,
    roles JSON,
    products JSON,
    providers JSON,
    source_file TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS courses(
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    summary TEXT,
    duration_in_hours INT,
    url TEXT,
    last_modified TIMESTAMPTZ,
    levels JSON,
    roles JSON,
    products JSON,
    source_file TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS levels(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    source_file TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS products(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    children JSON,
    source_file TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS roles(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    source_file TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS subjects(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    children JSON,
    source_file TEXT NOT NULL
);