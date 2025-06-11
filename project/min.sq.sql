select *
from parks_and_recreation.employee_demographics;


select first_name
from parks_and_recreation.employee_demographics;

select first_name,last_name,birth_date
from parks_and_recreation.employee_demographics;

select first_name,
last_name,
birth_date,
age,
(age+10)*10+10
from parks_and_recreation.employee_demographics;

#distinct
select distinct gender
from parks_and_recreation.employee_demographics;

select distinct first_name,gender
from parks_and_recreation.employee_demographics;

#WHERE clause

select * 
from employee_salary
where first_name= 'Leslie'
;

select *
from employee_demographics
where gender != 'female'
;

select *
from employee_demographics
where birth_date > '1985-01-01'
;

# logical operation and or not

select *
from employee_demographics
where birth_date > '1985-01-01'
and gender = 'male'
;

select *
from employee_demographics
where birth_date > '1985-01-01'
or gender = 'male'
;

select *
from employee_demographics
where birth_date > '1985-01-01'
or not gender = 'male'
;

select *
from employee_demographics
where (first_name = 'leslie' and age = 44) or age > 55
;

--- like statement
---- % and _ ------

select *
from employee_demographics
where first_name like 'jer%'
;

select *
from employee_demographics
where first_name like 'er%'
;

select *
from employee_demographics
where first_name like '%er%'
;

select *
from employee_demographics
where first_name like '_om'
;

select *
where first_name like 'TO_'
;

select *
from employee_demographics
where first_name like '_om'
;

select *
from employee_demographics
where first_name like 'A__'
;

select *
from employee_demographics
where first_name like 'A___'
;

select *
from employee_demographics
where first_name like 'A___%'
;

select *
from employee_demographics
where birth_date LIKE '1989%'
;


#GROUP BY

select gender
from employee_demographics
group by gender
;

select gender , avg(age)
from employee_demographics
group by gender
;

select occupation, salary
from  employee_salary
group by occupation, salary
;

select gender , avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender
;

# order by

select *
from employee_demographics
order by first_name asc;

select *
from employee_demographics
order by first_name desc;

select *
from employee_demographics
order by gender, age;

select *
from employee_demographics
order by gender, age desc;

select *
from employee_demographics
order by age, gender;

#mitunim gahi vaghta addad marbout be position un sotoon ro bezarin k order kone vali behtare anjam nadi
select *
from employee_demographics
order by 5, 4;

#having vs where
 # inja age where estefade koni javabi nemigiri chon majboori bade from where ro biyare va tabe tajamoee mesle avg dari , 
 # hanuz kode marbout be group by kar nakarde k betoone averege ro behet bedeh benabarin miyae az dastoor having stefade mikonim:
 # tavabe tajamooee mesle avg sum count max min dashti bayad az having estefade koni
 
 # in code alon javab nemide
select gender , avg(age)
from employee_demographics
where avg(age) > 40
group by gender
;

#in javabe
select gender , avg(age)
from employee_demographics
group by gender
having avg(age) > 40
;

# inja chon to ghesmate where tavabe tajmoee nakhasti hale where ro biyari mituni ba having ham tarkib koni

select occupation, avg(salary)
from employee_salary
where occupation like '%manager%'
group by occupation
;

select occupation, avg(salary)
from employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary) > 70000
;

#limit & Aliasing
# limit: tedad satrhaiee ro k mikhay neshun bede behet as table ro barat mahdood mikone

select * 
from employee_demographics
limit 3
;

# mituni limit ro ba order tarkib kone khorujihaye behtari behet bede masalan 3 ta as senbalatarin karmanda
select * 
from employee_demographics
order by age desc
limit 3
;

 # yani boro radif yeki bad az dovomi
 select * 
from employee_demographics
order by age desc
limit 2, 1
;

#aliasing: change the name of the coulumn

select gender, avg(age) as avg_age
from employee_demographics
group by gender
having avg_age > 40
;
# intori ham mitunim taghiier bedim esme sotoono
select gender, avg(age) avg_age
from employee_demographics
group by gender
having avg_age > 40
;

#joins: 
select *
from employee_demographics;

select * 
from employee_salary;

#inner join : satrhayee ke toye har jadval meghdar moshtarak daran barmigardoone
select *
from employee_demographics
inner join employee_salary
	on employee_demographics.employee_id = employee_salary.employee_id
;
# toye in jadval age negah koni radif 2 nist chon employee salary satre dovom nadasht.alter

# inja mitooni baraye inke rahattar kod benivisi as aliasing stefade koni beheshun esm bedi k sakht nabashe typ kardanesh

select *
from employee_demographics as EDEM
inner join employee_salary as ESAL
	on EDEM.employee_id = ESAL.employee_id;
    
#HALA MIKHAYEM YE TEDADI AZ SOOTUNHARO DASHTE BASHIM MITUNIM TO GHESMATE SELECT ADDRES BEDIM VALI HATMAN GHESMAT MOSHTARAKARO BAYAD begI
#AZ KOODOM TABALE BAR MIDARI

select ESAL.employee_id, age, occupation
from employee_demographics as EDEM
inner join employee_salary as ESAL
	on EDEM.employee_id = ESAL.employee_id;
    
    
#OUTER JOINS: inja ma do model join darim left joins va right joins 
#LEFT JOINS: hame satrhaye jadval samte chap ro negah midare va faghat maghadire montabegh az jadvale samte rast ro miyare
# age too jadvale samte rast maghadire montabegh nabashe meghdar null namayesh mide

select *
from employee_demographics as EDEM
left join employee_salary as ESAL
	on EDEM.employee_id = ESAL.employee_id;
    
#RIGHT JOINS: Barax
select *
from employee_demographics as EDEM
right join employee_salary as ESAL
	on EDEM.employee_id = ESAL.employee_id;
    
#SELF JOIN: mamulan baraye namayesh dadehaye selsele maratebi estefade mishe
#darvaghe mikhaim tu ye radif ro be ham join nakonim masalan radif aval az jadval avali ba radif dovom az ye jadaval dige hamradif shan
# hala inja hardo jadval ro az slary bardashte

select *
from employee_salary as emp1
join employee_salary as emp2
on emp1.employee_id+1 = emp2.employee_id;

# hala mikhaim daghghan entekhab konim kodum sotunha bashan

select emp1.employee_id as emp_santa,
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa,
emp2.first_name as first_name_santa,
emp2.last_name as last_name_santa
from employee_salary as emp1
join employee_salary as emp2
on emp1.employee_id+1 = emp2.employee_id;
    
    #joining mutiple tables together (1:20)
    
    select *
    from employee_demographics as dem
    inner join employee_salary as sal
    on dem.employee_id = sal.employee_id;
    
    #in ye refrence table 
    select *
    from parks_departments;
    
    # to code khune 307 age negah koni ghablan 2 table ro join karde 
    # hala mikhad un 2taro ba table 313 ke hamun refrence table hast join kone : betor koli in 2ta table bala to ghesmate department id baham 
    #eshterak daran pas ma mikhaim az in tarigh baham join shan
    
    select *
    from employee_demographics as dem
    inner join employee_salary as sal
    on dem.employee_id = sal.employee_id
    inner join  parks_departments as pd
    on sal.dept_id = pd.department_id;
    
    # unions: tu inja be surte radifi mituni table haro ba ham tarkib koni tu join miomadi barasase sootoone moshabe baham join mikardi
    #inja radifha mitunan zire ham gharar begiran
    
    #by defalt union tu halate union distinct hast tu in halat khodesh miyad az 2ta table dublicate haro hazf mikone
    select first_name, last_name
    from employee_demographics
    union
    select first_name, last_name
    from employee_salary;
    
    #age mikhay tamame radifha biyad tush bayad union all ro estefade koni
    select first_name, last_name
    from employee_demographics
    union all
    select first_name, last_name
    from employee_salary;
    
    # فکر کن شرکت داره ورشکست میشه و می خواد شناسایی کنه کی تو شرکت از همه سنش بالاتره و کی بیشترین حقوق رو می گیره که اخراجشون کنه (1:33)
    
    select first_name, last_name, 'old lady' as label
    from employee_demographics
    where age> 40 and gender = 'female'
    union
    select first_name, last_name, 'old man' as label
    from employee_demographics
    where age > 40 and gender = 'male'
    union
    select first_name, last_name , 'highly paid employee' as label
    from employee_salary
    where salary > 70000
    order by first_name, last_name
    ;
    
    #string functions
    # اینها توابعی هستن که برای کار کردن با داده های متنی استفاده میشن

    #length
select length('skyfall');

# مثلا می خوایم بدونیم اندازه اسم هرکدوم از کارمندا چقدره چنتا حرف داره اسمشون
#یا مثلا می خوای شماره تلفنهارو چک کنی می خوای ببینی همشون 10 رقمی هستن یا نه
select first_name, length(first_name)
from employee_demographics;

# اینجا یعنی بر اساس ستون دوم مرتب کن
select first_name, length(first_name)
from employee_demographics
order by 2;

#upper  lower

select upper('sky');
select lower('sky');

select first_name, upper(first_name)
from employee_demographics
;

select first_name, lower(first_name)
from employee_demographics
;

#trim : برای حذف فضای خالی از ابتدا و انتهای رشته استفاده میشه   lefttrim   righttrim
select ltrim('         sky        ');
select rtrim('         reza     ');

# وقتی می خوای چنتا کاراکتر از یه رشته حروف رو انتخاب کنی از این دستور استفاده می کنی اینجا 4 حرف اول از اسمهارو می خواد نشون بده
select first_name, left(first_name, 4)
from employee_demographics;

select first_name, 
left(first_name, 4),
right(first_name, 4)
from employee_demographics;

#substring: in ye ghesmati az ye string ro estekhrj mikone
# masalan inja gofte bro to first name ro harfe sevom bad 2 ta khunaro behem neshun bede chiye
select first_name, 
left(first_name, 4),
right(first_name, 4),
substring(first_name,3,2)
from employee_demographics;

# masalan mikhaim bebinim harkodum az karmanda tu che ahi be donya umadan aval chek kon bebin chandomi ro bayad kharej koni
select birth_date
from employee_demographics;
# inja fahmidim bayad bere khune 6 bad 2taro bardare mishe mah tavalod

select first_name,last_name,birth_date,
substring(birth_date,6,2) as birth_month
from employee_demographics;

#replace: migim chio koja jaygozine chi kon
select first_name, last_name, birth_date, replace(birth_date,'19','' )
from employee_demographics;

#locate: location un jai ke mikhay ro moshakhas mikone 
select locate('e','reza');

select first_name, locate('an',first_name)
from employee_demographics
;

#concat: in kheyli karbordiye chon mituni tarkib koni reshteharo   concatenation (1:46)
select first_name, last_name,
concat(first_name,'   ',last_name) as full_name
from employee_demographics;

#case statements : dar zaban sql baraye estefade az if-else az case statemnet stefade mishe

select first_name, 
last_name,
age,
case
   when age <= 30 then 'young'
   when age between 31 and 50 then 'old'
   when age >= 50 then 'on death door'
end as age_braket
from employee_demographics;
  
  
  # mikhaim be karmandamoon bones bedim shrtamun ine age salarishun kamtar az 50000 bud 5darsad bones midim age bishtar az 50000 bud 7% bones
  # age finance bd 10%
#pay increase and bonus
  # --<50000 =5%
  # ---> 50000 = 7%
  # finance =10% bonus  ino age bery to jadval park negah koni mibini unike department id 6 marbut be finance
  
select first_name,
last_name, salary,
case
  when salary < 50000 then (salary * 0.05 )+ salary
  when salary >50000 then (salary * 0.07 )+ salary
  end as new_salary,
case
 when dept_id = 6 then salary * 0.10
 end as bonus
from employee_salary;


# subqueries: yek dastoor ya query dari k mikhay tu ye dasture dige ejra she.

select *
from employee_demographics
where employee_id in
			(select employee_id
            from employee_salary
            where dept_id = 1
            );
            
            
# mikhaim ye subqueri besazim k miangin hughugh ham b ma neshun bede. in avaliye k be dard nemikhore k ba group by neveshte shode
        
select first_name, last_name, salary, avg(salary)
from employee_salary
group by first_name, last_name,salary;


select first_name, last_name, salary,
(select avg(salary)
from employee_salary)
from employee_salary;

# joda joda av max  min , count age ro peyda kon

select gender,avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender;


# hala avg max age ro mikhaim peyda konim baraye hardota gender


select avg(max_age)
from 
(select max(age) as max_age
from employee_demographics
group by gender) as avg_max_age
;
 
#window function:
# Window Function: نتیجه برای هر ردیف نمایش داده می‌شه.
# GROUP BY: یک ردیف برای هر گروه برمی‌گردونه

select *
from employee_demographics
;

select *
from employee_salary
;

#group by:
select gender, count(salary), avg(salary)
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id
group by gender;

# window function:
select gender, avg(salary) over(partition by gender)
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

# masalan age ma bekhaim hamzaman etelalte dige ham dashte bashim behtare az windo function estefade konim mesle code paiin 

select dem.first_name, dem.last_name, gender,avg(salary) over(partition by gender)
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

select dem.first_name, dem.last_name, gender,sum(salary) over(partition by gender)
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

#Rolling Total جمع تجمعی مقداری در طول زمان یا ردیف‌های پشت‌سرهمه   
# از چت جی پی تی خواه برات مثال بزنه اگه یادت رفت

select dem.first_name, dem.last_name, salary, gender,
sum(salary) over(partition by gender order by dem.employee_id) as rolling_total
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

# inja alon hamintory ye sery row number be tartib baraye har radif ekhtesas mide hala age bakhaim masalalan in adad be tartib bar asas
# jensiat moratab shan bayad toye over partition bezanim
select dem.first_name, dem.last_name, salary, gender,
row_number() over()
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

#injA AGE NEGAH KONI AVAL KHANUMHARO SHOMARE BANDI KARD BAD DOBARE AZ 1 BARA MARDA
select dem.first_name, dem.last_name, salary, gender,
row_number() over(partition by gender)
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

#HALA MIKHAIM BAR ASAS SALARY MORATAB KONIM
select dem.first_name, dem.last_name, salary, gender,
row_number() over(partition BY GENDER ORDER BY SALARY desc)
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

#HALA MIKHAIM BEHESH RANK BEDIM VA YE ESM HAM BARAYE HARKUDUM TOYE RANK TO MITUNI CHON BARASAS SALARI BEHESH ROTBE DADI TO TA RANKE YEKSAN 
#BARAYE AFRADI K HUGHUGH YEKSAN DARAN DASHTE BASHI VALI BARAYE ROW NUMBER BARAYE HARKUDUM UNIC NUMBER DARIM
# FAGHAT YE CHIZI K HAST TO IN MODEL MASALAN VAGHTI 2TA RANK 5 DADE BADI RO 7 DADE 6 NADADE BARAYE DOSRSY KARDAN IN AS DENSE_RANK ESTEFADE MIKONIM

select dem.first_name, dem.last_name, salary, gender,
row_number() over(partition BY GENDER ORDER BY SALARY desc) AS ROW_NUM,
RANK() OVER(PARTITION BY gender ORDER BY SALARY desc) AS RANK_NUM
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

#DENSE_RANK
select dem.first_name, dem.last_name, salary, gender,
row_number() over(partition BY GENDER ORDER BY SALARY desc) AS ROW_NUM,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY SALARY desc) AS RANK_NUM
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;


#CTEs:   یک بخش موقت از کوئریه که بهت اجازه می‌ده نتایج میانی رو به‌طور خواناتر و مرتب‌تر ذخیره کنی و بعداً توی کوئری اصلی ازش استفاده کنی ، دستورهارو مرتب تر و قابل فهم تر میکنه مث ساب کوئری 
# its more profitional than subquery
with cte_example as 
(
select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from employee_demographics dem
join employee_salary sal
on dem.employee_id= sal.employee_id
group by gender
)
select *
from cte_example
;


with cte_example as 
(
select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from employee_demographics dem
join employee_salary sal
on dem.employee_id= sal.employee_id
group by gender
)
select avg(avg_sal)
from cte_example
;

#more complicated query with cte

with cte_example as 
(
select employee_id, gender, birth_date
from employee_demographics
where birth_date > '1985-01-01'
),
cte_example2 as
(select employee_id, salary
from employee_salary
where salary > 50000
)
select *
from cte_example
join cte_example2
on cte_example.employee_id= cte_example2.employee_id
;

# temporary table: darvagh ye table movaghat misazim na toye memorye computeremun
# عدد داخل پرانتز یعنی حداکثر تعداد کاراکترهایی که اون ستون می‌تونه ذخیره کنه

create temporary table tem_table
(first_name varchar(50),
last_name varchar (50),
favorite_movie varchar(100)
);

select*
from tem_table;

insert into tem_table
values('Zahra','Alavi','BETTER CAL SAUL');

select*
from tem_table;

-----------------------
select *
from employee_salary;

create temporary table salary_over_50k
select *
from employee_salary
where salary >= 50000;

select *
from salary_over_50k;

-------------------
#stored procedures: فزایش سرعت و بهینه‌سازی: چون توی دیتابیس ذخیره می‌شه، فقط یه‌بار کامپایل می‌شه و بعداً سریع‌تر اجرا می‌شه.
# جلوگیری از تکرار کد: اگه یه کوئری یا عملیات تکراری داری، می‌تونی یه‌بار بنویسی و هر وقت لازم شد، صداش کنس

create procedure large_salaries()
select *
from employee_salary
where salary >= 50000;

call large_salaries();

---------
# delimiter: وقتی چنتا سیمی کالن توی کدمون داریم باید از دلیمیتر استفاده کنیم که تشخیص بده کد کجا تموم شده  (2:46)
# Delimiter is a sign to end SQL statements.
# By default, it is ; but we can change it temporarily (e.g., to $$) when writing complex code like Stored Procedures.
# This helps SQL understand where the statement really ends.


DELIMITER $$
create procedure large_salaries3()
begin
  select *
  from employee_salary
  where salary >= 50000;
  select *
  from employee_salary
  where salary >= 10000;
end $$
DELIMITER ;

CALL LARGE_SALARIES3();

---------------------

DELIMITER $$
create procedure large_salaries4(IN p_employee_id int)
begin
  select salary
  from employee_salary
  where employee_id = p_employee_id
 ;
end $$
DELIMITER ;

CALL large_salaries4(1);

----------------------------------
#Triggers and Events : A trigger is an automatic action in MySQL that runs when a specific event (like INSERT, UPDATE, or DELETE) happens on a table.
#اینجا یه مشکل داره الان اسمم تو جدول سالاری اضافه شده ولی تو جدول دموگرافیک فقط نوله بعد بررسی کن مشکاو (2:54)
select *
from employee_demographics;

select * 
from employee_salary;


DELIMITER $$
create trigger employee_insert
  after insert on employee_salary
  for each row
begin
  insert into employee_demographics (employee_id, first_name, last_name)
  values (NEW.EMPLOYEE_ID, NEW.FIRST_NAME, NEW.LAST_NAME);
end $$
DELIMITER ;

insert into employee_salary(employee_id, first_name,last_name, occupation, salary, dept_id)
values(13, 'zahar','Alavi', 'Data analyst', 1000000, null);


select *
from employee_demographics;

select * 
from employee_salary;

---------------------------
#EVENTS 
# MIKHAIM BE SOORAT OUTOMATICLY HAKI SENESH BISHTAR AS 60 HAST RO RETIERD KONIM:

select * 
FROM employee_demographics;

delimiter $$
create event DELETE_retirees
on schedule every 30 second
do
begin
delete
FROM employee_demographics
where age IS NULL OR age >= 60;
end $$
delimiter ;

#age mesle man moshkel peyda kard bayed ino on koni
 show variables like 'event%';
 SHOW VARIABLES LIKE 'event_scheduler';
 SHOW EVENTS;
 #age on bud shayed ejaze delet  nadari to (3:04:11)yad mide chetor hal koni
 
 # باز حل نشد باید از چت جی پی تی کمک بگیرم
 DELETE FROM employee_demographics WHERE age >= 60;
 
 DROP EVENT IF EXISTS DELETE_retirees;
 
 DELIMITER $$  
CREATE EVENT DELETE_retirees  
ON SCHEDULE EVERY 1 month  
ON COMPLETION PRESERVE  
DO  
BEGIN  
  DELETE FROM employee_demographics WHERE age >= 60;  
END $$  
DELIMITER ;

select *
from employee_demographics;

