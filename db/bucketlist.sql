DROP TABLE cities;
DROP TABLE countries;

CREATE TABLE countries (
  id SERIAL8 primary key,
  name VARCHAR(255)
);

CREATE TABLE cities (
  id SERIAL8 primary key,
  country_id INT8 REFERENCES countries(id) ON DELETE CASCADE,
  name VARCHAR(255),
  visit_status INT8
);
