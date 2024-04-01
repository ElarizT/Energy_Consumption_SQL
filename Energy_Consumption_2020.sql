-- Selecting data I need 
Select Site_Name, Electric_Utility, Electricity_Usage,  Building_Type, Natural_Gas_Usage 
from energy_consumption1_2020;

-- Looking at date where Electric Utility is only APS
Select Site_Name, Electric_Utility, Electricity_Usage
from energy_consumption1_2020
Where Electric_Utility = 'APS';

-- Find total electricity usage for each utility
Select Electric_Utility, sum(Electricity_Usage) as Total_Usage
from energy_consumption1_2020
group by Electric_Utility;

-- Find out where electricity used more than average
Select Site_Name, Electric_Utility, Electricity_Usage
from energy_consumption1_2020
where Electricity_Usage > 
(Select avg(Electricity_Usage) from energy_consumption1_2020);

-- Look at 5 Building types used the most energy
Select sum(Electricity_Usage) as Total_Elec_Usage,  Building_Type
from energy_consumption1_2020
group by Building_Type
order by Total_Elec_Usage desc
limit 5;

-- Finding where natural gas is used and how much
Select Site_Name, Electric_Utility, Natural_Gas_Usage 
from energy_consumption1_2020
where Natural_Gas_Usage != 0;

-- Looking for Electricity usage & Energy use intensity(in order) for places
Select Elec.Site_Name,Elec.Electricity_Usage, Inten.Energy_Use_Intensity
from energy_consumption1_2020 Elec
Join energy_consumption2 Inten
	on Elec.Site_Name = Inten.Site_Name
where Inten.Energy_Use_Intensity > 0
order by 3;

-- Find total energy use intensity for each building type
Select Elec.Building_Type,
sum(Inten.Energy_Use_Intensity) as Total_Elec_Intensity
from energy_consumption1_2020 Elec
Join energy_consumption2 Inten
	on Elec.Site_Name = Inten.Site_Name
where Inten.Energy_Use_Intensity > 0
group by Elec.Building_Type
order by Total_Elec_Intensity;

-- Create a View for vusalizations later
Create View UsedNaturalGas as
Select Site_Name, Electric_Utility, Natural_Gas_Usage 
from energy_consumption1_2020
where Natural_Gas_Usage != 0;

Create View EnergyIntensityPerBuildingType as
Select Elec.Building_Type,
sum(Inten.Energy_Use_Intensity) as Total_Elec_Intensity
from energy_consumption1_2020 Elec
Join energy_consumption2 Inten
	on Elec.Site_Name = Inten.Site_Name
where Inten.Energy_Use_Intensity > 0
group by Elec.Building_Type
order by Total_Elec_Intensity;

-- Check if Views are created correctly
Select * from energyintensityperbuildingtype;

Select * from usednaturalgas;