/*Performance des représentants commerciaux
Mesurer le chiffre d’affaires généré par chaque employé chargé des ventes.*/

use toys_and_models;

select *
	from (select e.lastName, e.firstName, e.employeeNumber, sum(quantityOrdered * priceEach) as saleAmount, DATE_FORMAT(orderDate, '%Y-%m') as orderMonth,
		rank () over(partition by DATE_FORMAT(orderDate, '%Y-%m') order by sum(quantityOrdered * priceEach)desc) as ranking
        from employees as e
                  join customers as c on c.salesRepEmployeeNumber = e.employeeNumber
                  join orders as o on o.customerNumber = c.customerNumber
                  join orderdetails as od on od.orderNumber = o.orderNumber
                  join offices as offi on offi.officeCode = e.officeCode
		group by e.employeeNumber, e.lastName, e.firstName, DATE_FORMAT(orderDate, '%Y-%m')) as rankedEmployee
		where ranking < 3;