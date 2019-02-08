DROP TABLE cities;
DROP TABLE countries;

CREATE TABLE countries (
  id SERIAL8 primary key,
  name VARCHAR(255)
);

CREATE TABLE cities (
  id SERIAL8 primary key,
  name VARCHAR(255),
  country_id INT8 REFERENCES countries(id),
  visit_status VARCHAR(255)
);
