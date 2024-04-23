SELECT * FROM sqlclean.nav;

-- Standardardised  date fromat
-- First, alter the table to add a new column to hold the converted date
ALTER TABLE sqlclean.nav
ADD SALEDATECONVERT DATE;

-- Update the new column with the converted date format
UPDATE sqlclean.nav
SET SALEDATECONVERT = STR_TO_DATE(SaleDate, '%M %d, %Y');

SELECT * FROM sqlclean.nav;
------------------------------------------------------------------------------------------------
-- POPULATE PROPERTY ADDRESS DATA

SELECT * FROM sqlclean.nav
WHERE PropertyAddress  is NULL;
-- THERE IS NO NULL PROPERTY VALUE
-----------------------------------------------------------------------------------------------
-- BREAKING OUT ADDRESS INTO SINGLE COLUMN [ADDRESS,CITY,STATE]


SELECT PropertyAddress FROM sqlclean.nav;

select 
substring_index(PropertyAddress,',',1) AS Address
from sqlclean.nav;

alter table sqlclean.nav
add Address varchar(50);

update sqlclean.nav
set Address = substring_index(PropertyAddress,',',1);


SELECT Address FROM sqlclean.nav;
-- Done for Address

select 
substring_index(PropertyAddress,',',-1) AS city
from sqlclean.nav;

alter table sqlclean.nav
add city varchar(50);

update sqlclean.nav
set city = substring_index(PropertyAddress,',',-1);

SELECT city FROM sqlclean.nav;
SELECT * FROM sqlclean.nav;

-- done for city
-------------------------------------------------------------------------------------------
-- converting Y & N to YES & NO in sold as vacant in field
 
select distinct(SoldAsVacant),count(SoldAsVacant)
from sqlclean.nav
group by SoldAsVacant
order by 2;

-- there will be 15 Y and 108 N WE have to convert it into YES & NO

select 
case
	when SoldAsVacant = "Y" then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
end as SoldAsVacant
from sqlclean.nav;

update sqlclean.nav
set SoldAsVacant = case
	when SoldAsVacant = "Y" then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
end ;

select distinct(SoldAsVacant),count(SoldAsVacant)
from sqlclean.nav
group by SoldAsVacant
order by 2;

-- There will be no Y & N in sold as vacant in field
-------------------------------------------------------------------------------------------------
-- NOW WE DELETE UNUSED COLUMN 

SELECT * FROM sqlclean.nav; 

ALTER TABLE sqlclean.nav
DROP COLUMN TaxDistrict,
DROP COLUMN OwnerName,
DROP COLUMN PropertyAddress;

ALTER TABLE sqlclean.nav
DROP COLUMN SaleDate;
------------------------------------------------------------------------------------------------
-- FROM THIS OUR DATA IS CLEAN AND READY TO ANALYSIS IN THIS DATA CLEANING IN SQL
-- WE FIRST BROUGHT NASH-VILLE-HOUSING Data And perform cleaning
