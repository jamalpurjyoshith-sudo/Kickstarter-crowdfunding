SELECT * FROM crowdfunding_kickstarter.projects;

-- Total number of projects based on Outcome
SELECT state, COUNT(*) AS total_projects
FROM crowdfunding_kickstarter.projects
GROUP BY state
ORDER BY total_projects DESC;

-- Total number of projects based on locations --
SELECT country, count(*) AS total_projects
FROM crowdfunding_kickstarter.projects
GROUP BY country
ORDER BY total_projects DESC;

-- Total number of projects based on category --
SELECT c.name, COUNT(p.ProjectID) AS total_projects
FROM crowdfunding_kickstarter.projects
JOIN csv_crowdfunding_category.category c ON p.category_id = c.id
GROUP BY c.name
ORDER BY total_projects DESC;

-- Total Number of Projects By Year, Quarter & Month --
SELECT 
    YEAR(created_at_readable_date) AS year,
    QUARTER(created_at_readable_date) AS quarter,
    MONTHNAME(created_at_readable_date) AS month,
    COUNT(*) AS total_projects
FROM 
    crowdfunding_kickstarter.projects
GROUP BY 
    YEAR(created_at_readable_date), 
    QUARTER(created_at_readable_date), 
    MONTHNAME(created_at_readable_date)
ORDER BY 
    YEAR(created_at_readable_date) DESC, 
    QUARTER(created_at_readable_date), 
    MONTHNAME(created_at_readable_date);
    
-- Total Number of Projects By Amount Raised-
SELECT 
    name AS project_name,
    state,
    (goal * static_usd_rate) AS amount_raised
FROM 
    crowdfunding_kickstarter.projects
WHERE 
    state = 'successful'
    order by amount_raised desc;
    
    -- Total Number of Successful Projects By Backers --
SELECT 
    name AS project_name,
    state,
    backers_count
FROM 
    crowdfunding_kickstarter.projects
WHERE 
    state = 'successful'
ORDER BY 
    backers_count DESC;

-- Percentage of Overall Successful Projects --
SELECT 
    (COUNT(CASE WHEN state = 'successful' THEN 1 END) * 100.0 / COUNT(*)) AS success_percentage
FROM 
    crowdfunding_kickstarter.projects;


-- Percentage of successful projects by category
SELECT 
    c.name AS category_name,
    COUNT(p.ProjectID) AS total_projects,
    COUNT(CASE WHEN p.state = 'successful' THEN 1 END) AS successful_projects,
    (COUNT(CASE WHEN p.state = 'successful' THEN 1 END) * 100.0 / COUNT(p.ProjectID)) AS success_percentage
FROM 
    crowdfunding_kickstarter.projects p
JOIN 
    csv_crowdfunding_category.category c 
    ON p.category_id = c.id
GROUP BY 
    c.name
ORDER BY 
    success_percentage DESC;





