
AIR CARGO ANALYSIS


  Create database aircargo;
  use aircargo

  Import datasets from the wizard



1.Create an ER diagram for the given airlines database.




2.Write a query to create route_details table using suitable data types for the fields, such as route_id, flight_num,
 origin_airport, destination_airport, aircraft_id, and distance_miles. Implement the check constraint for the flight number and 
 unique constraint for the route_id fields. Also, make sure that the distance miles field is greater than 0.
 
   Create table route_details (
   route_id int,
   flight_num int,
   origin_airport char,
   destination_airport char,
   aircraft_id varchar(20),
   distance_miles int,
   unique(route_id),
   check(distance_miles>0)
   );


3.Write a query to display all the passengers (customers) who have travelled in routes 01 to 25. Take data  from the passengers_on_flights table.
  
  select customer.first_name, customer.last_name, passengers_on_flights.route_id from customer  
  inner join passengers_on_flights 
  on customer.customer_id = passengers_on_flights.customer_id
  where passengers_on_flights.route_id between 0 and 25
  order by passengers_on_flights.route_id;


4.Write a query to identify the number of passengers and total revenue in business class from the ticket_details table.
 
  select c. first_name, last_name, sum(t.Price_per_ticket) as total_revenue, t.class_id from customer c	
  join ticket_details t
  on c.customer_id = t.customer_id
  where class_id = "bussiness"
  group by c.first_name, c.last_name
  order by t.Price_per_ticket desc;





5.Write a query to display the full name of the customer by extracting the first name and last name from the customer table.

  select concat(first_name, " ", last_name) as Full_name from customer;


6.Write a query to extract the customers who have registered and booked a ticket. Use data from the customer and ticket_details tables.
  
  select c. first_name,last_name, t.no_of_tickets, t.class_id from customer c	
  join ticket_details t
  on c.customer_id = t.customer_id
  where no_of_tickets > 0;


7.Write a query to identify the customer’s first name and last name based on their customer ID and brand (Emirates) from the ticket_details table.
  
  select c. first_name, c.last_name, t.customer_id, t.brand, t.class_id from customer c	
  join ticket_details t
  on c.customer_id = t.customer_id
  where t.brand = "emirates"
  order by t. customer_id;

8.Write a query to identify the customers who have travelled by Economy Plus class using Group By and Having clause on the passengers_on_flights table.
   
  select c.first_name, p. class_id from customer c	
  join passengers_on_flights p
  on c.customer_id = p.customer_id
  group by c. first_name, p. class_id 
  having p.class_id= "economy plus";

9.Write a query to identify whether the revenue has crossed 10000 using the IF clause on the ticket_details table.
 
  select sum(Price_per_ticket)as Total_revenue, if (sum(Price_per_ticket) >10000 , "yes" , "no" )as 
  Reveune_crossed_or_not from ticket_details;


10.Write a query to create and grant access to a new user to perform operations on a database.

   CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';
   GRANT permission_type ON aircargo.ticket_details TO 'username'@'localhost';


11.Write a query to find the maximum ticket price for each class using window functions on the ticket_details table.
   
   select * , max(Price_per_ticket)
   over(partition by class_id,brand) as maxticket
   FROM aircargo.ticket_details
   order by brand;


12.Write a query to extract the passengers whose route ID is 4 by improving the speed and performance of the passengers_on_flights table.

   select c.customer_id, c.first_name, c.last_name, p.aircraft_id, p.route_id from customer c inner join passengers_on_flights p 
   on c. customer_id = p. customer_id
   where route_id  = 4;


13.For the route ID 4, write a query to view the execution plan of the passengers_on_flights table.

   create view execution_plan
   as 
   select c.first_name, c.last_name , p.* from customer c inner join passengers_on_flights p 
   on c. customer_id = p. customer_id
   where route_id  = 4;


14.Write a query to calculate the total price of all tickets booked by a customer across different aircraft IDs using rollup function.

   select customer_id,aircraft_id, sum(Price_per_ticket) as total from ticket_details
   group by  customer_id, aircraft_id with rollup ;


15.Write a query to create a view with only business class customers along with the brand of airlines.
  
   create view business_class
   as 
   select c.first_name, c.last_name , t.brand from customer c inner join ticket_details t 
   on c. customer_id = t. customer_id
   where class_id = "bussiness" ;


16.Write a query to create a stored procedure to get the details of all passengers flying between a range of routes defined in run time.
 Also, return an error message if the table doesn't exist.
  
  

17.Write a query to create a stored procedure that extracts all the details from the routes table where the travelled distance is more than 2000 miles.
   
 Create table route_details 
 (route_id int,
 flight_num int,
 origin_airport char,
 destination_airport char,
 aircraft_id varchar(20),
 distance_miles int,
 unique(route_id),
 check(distance_miles>0)
 );

18.Write a query to create a stored procedure that groups the distance travelled by each flight into three categories. 
   The categories are, short distance travel (SDT) for >=0 AND <= 2000 miles, 
   intermediate distance travel (IDT) for >2000 AND <=6500, and 
   long-distance travel (LDT) for >6500.

   select *,
   case 
   when distance_miles >=0 AND distance_miles <= 2000 then "short distance travel (SDT)"
   when distance_miles >2000 and distance_miles <= 6500 then "intermediate distance travel (IDT)"
   when  distance_miles >6500 then "long-distance travel (LDT)"
   end as categories
   from routes;


19.Write a query to extract ticket purchase date, customer ID, class ID and specify if the complimentary services are provided for the specific class using a stored function in stored procedure on the ticket_details table.
   Condition:

   If the class is Business and Economy Plus, then complimentary services are given as Yes, else it is No


   select p_date, customer_id, class_id,
   CASE 
	when class_id = 'Business' or class_id = "economy plus" then 'Yes'
    else 'No' 
   end as Complimentary_service   
   from ticket_details
   order by customer_id;
   


20. Write a query to extract the first record of the customer whose last name ends with Scott using a cursor from the customer table.

    delimiter %%
    
   CREATE PROCEDURE scott ()
   BEGIN DECLARE a VARCHAR(255);
   DECLARE b VARCHAR(255); DECLARE cursor_1  CURSOR FOR SELECT last_name FROM customer
   WHERE last_name='scott';
   END;
   %% delimiter
   
   note : their is no customer who's last name is "scott" 
