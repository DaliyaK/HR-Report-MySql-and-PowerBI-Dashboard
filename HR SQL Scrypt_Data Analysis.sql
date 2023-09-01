
#Сколько женщин и мужчин сейчас работают в компании?
SELECT gender, count(*) AS count 
FROM hr
WHERE age >=18 AND termdate IS NULL
GROUP BY gender;

#Разброс по национальностям
SElECT race, count(*) as count
FROM hr
WHERE age >=18 AND termdate IS NULL
GROUP BY race
ORDER BY count(*) DESC;

#Распределение по возврасту
SELECT MIN(age) AS youngest,
       MAX(age) AS oldest
FROM hr
WHERE age >=18 AND termdate IS NULL;

SELECT CASE
     WHEN age <= 24 THEN '18-24'
     WHEN age <= 34 THEN '25-34'
     WHEN age <= 44 THEN '35-44'
     WHEN age <= 54 THEN '45-54'
     ELSE '55-65'
	END AS age_group,
count(*) AS count
FROM hr
WHERE age >=18 AND termdate IS NULL
GROUP BY age_group
ORDER BY age_group;

#Распределение по возврасту и полу
SELECT MIN(age) AS youngest,
       MAX(age) AS oldest
FROM hr
WHERE age >=18 AND termdate IS NULL;

SELECT CASE
     WHEN age <= 24 THEN '18-24'
     WHEN age <= 34 THEN '25-34'
     WHEN age <= 44 THEN '35-44'
     WHEN age <= 54 THEN '45-54'
     ELSE '55-65'
	END AS age_group, gender,
count(*) AS count
FROM hr
WHERE age >=18 AND termdate IS NULL
GROUP BY age_group, gender
ORDER BY age_group, gender;

#Распределение по локации
SELECT location, count(*) as count
FROM hr
WHERE age >=18 AND termdate IS NULL
GROUP BY location;

#Среднее количество лет работы в компании
SELECT round(avg(datediff(termdate, hire_date))/365) as avg_length_emp_Y
FROM hr
WHERE age >=18 AND termdate IS NOT NULL AND termdate <= curdate();

#Распределение по полу и депртаменту
SELECT department, gender, count(*) AS count
FROM hr
WHERE age >=18 AND termdate IS NULL
GROUP BY department, gender
ORDER BY department, gender;

#Распределение по должностям внутри компании
SELECT jobtitle, count(*) as count
FROM hr
WHERE age >=18 AND termdate IS NULL
GROUP BY jobtitle
ORDER BY jobtitle;

#Коэффициент текучести кадров
SELECT department, total_count, termdate_count, ROUND(100*(termdate_count/total_count)) as turnover_rate
FROM (
    SELECT department,
    count(*) as total_count,
    sum(CASE WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1 ELSE 0 END) AS termdate_count
    FROM hr
    WHERE age >= 18
    GROUP BY department) as subquery_1
ORDER BY turnover_rate DESC;

#Распределение по городам
SELECT location_state, count(*) as count
FROM hr
WHERE age >=18 AND termdate IS NULL
GROUP BY location_state
ORDER BY COUNT DESC;

#Распределение по годам
SELECT 
    year,
    hires,
    terminations,
    hires - terminations AS net_change,
    round(((hires - terminations)/hires * 100), 2) AS net_change_percent
FROM (
     SELECT 
       YEAR(hire_date) AS year,
       count(*) as hires,
       SUM(CASE WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
	 FROM hr WHERE age >=18
	 GROUP BY YEAR(hire_date)) as query_1
ORDER BY year;  
   
#Средний срок пребывания на должности - распределение по департаментам
SELECT department, round(avg(datediff(termdate, hire_date)/365)) AS avg_tenure
FROM hr
WHERE termdate <= curdate() AND age >=18 AND termdate IS NOT NULL
GROUP BY department;

     

    





