#I answered all the SQL database problems on Leetcode.com, now sum all of them up here, and upload for housekeeping purpose. 


#=====================================================================
#175. Join tables and select features 
##https://leetcode.com/problems/combine-two-tables/description/

Select FirstName, LastName, City, State 
From Person Left Join Address
On Person.PersonID = Address.PersonID


#=====================================================================
#181. Employees earning more than their managers 
## https://leetcode.com/problems/employees-earning-more-than-their-managers/description/

select e1.Name as Employee
from Employee e1, Employee e2
where e1.ManagerId =e2.Id and e1.Salary >e2.Salary 
#### or ####  
# in e2 we only need the managerID 
select e1.Name as Employee
from Employee e1 join Employee e2 on e1.ManagerId = e2.Id
where e1.Salary >e2.Salary 



#=====================================================================
#184 Department highest salary 
##https://leetcode.com/problems/department-highest-salary/description/
select d.Name as Department, e.Name as Employee, e.Salary as Salary
from Employee e join Department d on e.DepartmentId = d.Id 
where (e.DepartmentID, e.Salary) in (
select DepartmentId, MAX(Salary) 
    from Employee
    group by DepartmentId 
)


#=====================================================================
#176  Second Highest Salary 
## https://leetcode.com/problems/second-highest-salary/description/
## key: what if only one record in the data base, 
select  
(select distinct Salary 
from Employee 
order by Salary desc 
limit 1 offset 1 ) as SecondHighestSalary
 


#=====================================================================
# 177 Nth Highest Salary 
## https://leetcode.com/problems/nth-highest-salary/description/
# key: generate the rank of the data/Salary, rank() or dense_rank()
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
declare M int;
set M=N-1;
  RETURN (
      # Write your MySQL query statement below.
      select distinct Salary 
      from Employee
      order by Salary DESC limit M, 1
  );
END

### key here we need to define "decalre M int" and set a new variable M =N-1. 

#=====================================================================
# 178 Rank Scores
#https://leetcode.com/problems/rank-scores/description/
select S1.ScorE, count(distinct S2.Score) Rank 
from Score S2 join Score S2 on S.Score <=S1.Score
group by S1.Id 
order by S1.Score desc 


#=====================================================================
# 178  Consecutive Numbers 
## https://leetcode.com/problems/consecutive-numbers/description/
select distinct l1.Num as ConsecutiveNums
from logs l1, logs l2, logs l3 
where l1.Id = l2.Id-1
and l2.Id = l3.Id-1 
and l1.Num = l2.Num
and l2.Num = l3.Num


#=====================================================================
# 185 Departmet top three salaries 
## https://leetcode.com/problems/department-top-three-salaries/description/
select e1.Salary, d.name as Department, e1.Name as Employee
from Employee e1 join Department d on e1.DepartmentId = d.Id
where 3> (
select count(distinct e2.Salary)
from Employee e2
where 
e2.Salary >e1.Salary
and e2.DepartmentId = e1.DepartmentId)


#=====================================================================
# 197 Rasing Temperature 
##https://leetcode.com/problems/rising-temperature/description/
# notes: to_date convert to date or string, while to_days convert date to numeric days 
select w1.Id
from Weather w1, Weather w2 
where to_days(w1.RecordDate) = to_days(w2.RecordDate)+1
and w1.Temperature > w2.Temperature 

#=====================================================================
# 182 Duplicate Emails 
## https://leetcode.com/problems/duplicate-emails/description/

select distinct Email
from Person  
group by Email
having count(Email) >1 
## or ## 
select distinct p1.Email
from Person p1 join Person p2
where P1.Id !=P2.Id and P1.Email = P2.Email

#=====================================================================
# 196. Delete Duplicate Emails 
## https://leetcode.com/problems/delete-duplicate-emails/description/
delete p1
from Person p1, Person p2 
where p1.Id>p2.Id and p1.Email = p2.Email 

#=====================================================================
# 262 Trips and Users 
## https://leetcode.com/problems/trips-and-users/description/
select Request_at as Day, round(count(Status <> "completed" or null) / count(*),2) as "Cancellation Rate"
from Trips join Users 
on Users_Id = Client_Id and Banned = "No" and Request_at between "2013-10-01" and "2013_10_03"
group by Request_at 

### note: has to include Null as any none null value (include false and o) will be counted.

