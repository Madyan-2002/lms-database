SELECT * FROM public.users
ORDER BY user_id DESC LIMIT 100;

CREATE USER ahmad WITH PASSWORD 'ahmad123';

GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO ahmad;

GRANT UPDATE, DELETE, DELETE ON roles TO ahmad;

REVOKE UPDATE, DELETE, SELECT ON roles FROM ahmad;

REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA PUBLIC FROM ahmad;

-- Create role

CREATE ROLE readonly_role;
GRANT readonly_role TO ahmad;

GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO readonly_role;

SELECT * FROM users;
SELECT * FROM categories;
SELECT * FROM courses;

SELECT users.full_name , users.email , roles.role_name
FROM users INNER JOIN roles
ON users.roles_id = roles.roles_id;

--------------------------------------------------------
SELECT c.title , cat.categories_name
FROM courses  c INNER JOIN categories cat
ON c.categories_id = cat.categories_id;

-------------------------------------------------------


SELECT u.full_name , a.country , a.city
FROM users u INNER JOIN addresses a
ON u.addresses_id = a.addresses_id;

