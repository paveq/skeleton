-- MySQL: Creates function that can be used to split strings
-- Requires INSERT privilege for the database
-- 
-- params: str, delimiter, position
-- Ex:
-- SELECT SPLIT_STR('a|bb|ccc|dd', '|', 3) as third;
--
-- +-------+
-- | third |
-- +-------+
-- | ccc   |
-- +-------+
--
-- Thanks to Federico!
-- http://blog.fedecarg.com/2009/02/22/mysql-split-string-function/

CREATE FUNCTION SPLIT_STR(
  x VARCHAR(255),
  delim VARCHAR(12),
  pos INT
)
RETURNS VARCHAR(255)
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
       LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
       delim, '');
