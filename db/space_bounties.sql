DROP TABLE IF EXISTS space_bounties;

CREATE TABLE space_bounties(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  species VARCHAR(255),
  bounty INT
);
