# Inventory Management System

This project is an **Inventory Management System** designed to efficiently manage and analyze data related to items, suppliers, and purchase orders. The system helps track inventory, identify trends, and calculate financial metrics using SQL queries.

## Features

1. **Top 5 Items by Stock**
   - List the top 5 items with the highest stock.
   - **Query:**
     ```sql
     SELECT ItemID, Name, StockQuantity 
     FROM (
          SELECT ItemID, Name, StockQuantity 
          FROM Items 
          ORDER BY StockQuantity DESC
          )
     WHERE ROWNUM < 6;
     ```

2. **Suppliers Without Purchase Orders**
   - Find suppliers who haven't supplied any purchase orders.
   - **Query:**
     ```sql
     SELECT SupplierID, Name
     FROM Suppliers
     WHERE 
     SupplierID NOT IN (
                     SELECT DISTINCT SupplierID FROM PurchaseOrders
                     );
     ```

3. **Item with the Highest Total Quantity Ordered**
   - Identify the item with the highest total quantity ordered.
   - **Query:**
     ```sql
     SELECT Name, ItemID, Total_Quantity
     FROM (
     SELECT I.Name, I.ItemID, O.OrderID, SUM(O.Quantity) AS Total_Quantity
     FROM Items I
     JOIN OrderDetails O
     ON 
     I.ItemID = O.ItemID
     GROUP BY I.Name, I.ItemID, O.OrderID
     ORDER BY Total_Quantity DESC
     )
     WHERE ROWNUM < 2;
     ```

     - **Alternate Solution:**
       ```sql
       SELECT I.Name, I.ItemID, O.OrderID, SUM(O.Quantity) AS Total_Quantity
       FROM Items I
       JOIN OrderDetails O
       ON 
       I.ItemID = O.ItemID
       GROUP BY I.Name, I.ItemID, O.OrderID
       ORDER BY Total_Quantity DESC
       FETCH FIRST 1 ROW ONLY;
       ```

4. **Recent Purchase Orders**
   - List all purchase orders made in the last 30 days.
   - **Query:**
     ```sql
     SELECT * FROM PurchaseOrders
     WHERE 
     OrderDate >= SYSDATE - 30;
     ```

5. **Total Revenue Generated**
   - Calculate the total revenue generated (stock price * quantity sold).
   - **Query:**
     ```sql
     SELECT SUM(I.Price * O.Quantity) AS Total_Revenue
     FROM Items I
     JOIN OrderDetails O
     ON 
     I.ItemID = O.ItemID;
     ```

6. **Out of Stock Items**
   - List items that are out of stock.
   - **Query:**
     ```sql
     SELECT ItemID, Name
     FROM Items 
     WHERE 
     StockQuantity = 0;
     ```

7. **Total Value of Items in Stock**
   - Get the total value of items in stock (stock quantity * price per item).
   - **Query:**
     ```sql
     SELECT SUM(StockQuantity * Price) AS Total_Value
     FROM Items;
     ```

8. **Supplier with Most Purchased Items**
   - Find the supplier with the most purchased items.
   - **Query:**
     ```sql
     SELECT S.SupplierID, S.Name, SUM(O.Quantity) AS TotalCost
     FROM Suppliers S
     JOIN PurchaseOrders P
     ON 
     S.SupplierID = P.SupplierID
     JOIN OrderDetails O
     ON
     P.OrderID = O.OrderID
     GROUP BY S.SupplierID, S.Name, TotalCost
     ORDER BY TotalCost DESC
     FETCH FIRST 1 ROW ONLY;
     ```

9. **Items Below Stock Quantity < 20**
   - Find items with stock quantity below 20.
   - **Query:**
     ```sql
     SELECT * FROM Items 
     WHERE 
     StockQuantity < 20
     ORDER BY StockQuantity DESC;
     ```

10. **Total Amount Invoiced by Suppliers**
    - List all suppliers and the total amount they’ve invoiced (i.e., total cost of all their purchase orders).
    - **Query:**
      ```sql
      SELECT S.SupplierID, S.Name, SUM(P.TotalCost) AS Total_Invoice
      FROM Suppliers S
      JOIN PurchaseOrders P
      ON
      S.SupplierID = P.SupplierID
      GROUP BY S.SupplierID, S.Name
      ORDER BY Total_Invoice DESC;
      ```

## How to Use

1. **Setup the Database**:
   - Use the provided `.sql` or `.csv` files to populate your database.
   - Ensure that all tables (e.g., `Items`, `Suppliers`, `PurchaseOrders`, `OrderDetails`) are correctly created and populated.

2. **Run the Queries**:
   - Copy and execute the provided queries in your SQL environment (e.g., Oracle SQL Developer, MySQL Workbench).

3. **Analyze the Results**:
   - Use the output from the queries to make informed decisions about inventory and supplier management.

## Project Requirements

- **Database Tables**:
  - `Items (ItemID, Name, Price, StockQuantity, ReorderLevel)`
  - `Suppliers (SupplierID, Name, Contact)`
  - `PurchaseOrders (OrderID, SupplierID, OrderDate, TotalCost)`
  - `OrderDetails (OrderDetailID, OrderID, ItemID, Quantity)`

- **Tools**:
  - SQL environment (e.g., Oracle SQL Developer, MySQL Workbench).

## Contributing

Feel free to contribute by suggesting new queries, improving the existing ones, or providing additional features for the project. Fork this repository and create a pull request with your changes.

## License

This project is open-source.

