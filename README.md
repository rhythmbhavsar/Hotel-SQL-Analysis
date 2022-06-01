# Hotel-SQL-Analysis

## Database Information

The Database
Hotel (Hotel_No, Name, Address) Room (Room_No, Hotel_No, Type, Price) Booking (Hotel_No, Guest_No, Date_From, Date_To, Room_No) Guest (Guest_No, Name, Address)

**Creating the Tables**

(Ignoring PKs and FKs) CREATE TABLE hotel ( hotel_no CHAR(4) NOT NULL, name VARCHAR(20) NOT NULL, address VARCHAR(50) NOT NULL);
CREATE TABLE room ( room_no VARCHAR(4) NOT NULL, hotel_no CHAR(4) NOT NULL, type CHAR(1) NOT NULL, price DECIMAL(5,2) NOT NULL);
CREATE TABLE booking (hotel_no CHAR(4) NOT NULL, guest_no CHAR(4) NOT NULL, date_from DATETIME NOT NULL, date_to DATETIME NULL, room_no CHAR(4) NOT NULL); Dates: YYYY-MM-DD
CREATE TABLE guest ( guest_no CHAR(4) NOT NULL, name VARCHAR(20) NOT NULL, address VARCHAR(50) NOT NULL);

**Populating the Tables**

 INSERT INTO hotel VALUES ('H111', 'Grosvenor Hotel‘, 'London'); INSERT INTO room VALUES ('1', 'H111', 'S', 72.00); INSERT INTO guest VALUES ('G111', 'John Smith', 'London'); INSERT INTO booking VALUES ('H111', 'G111', DATE'1999-01-01', DATE'1999-01-02', '1');

**Updating the Tables**

UPDATE room SET price = price*1.05;

Create a separate table with the same structure as the Booking table to hold archive records.
Using the INSERT statement, copy the records from the Booking table to the archive table relating to bookings before 1st January 2000. Delete all bookings before 1st January 2000 from the Booking table.

CREATE TABLE booking_old ( hotel_no CHAR(4) NOT NULL, guest_no CHAR(4) NOT NULL, date_from DATETIME NOT NULL, date_to DATETIME NULL, room_no VARCHAR(4) NOT NULL);
INSERT INTO booking_old (SELECT * FROM booking WHERE date_to < DATE‘2000-01-01'); DELETE FROM booking WHERE date_to < DATE‘2000-01-01';
Queries: Back to the Database Hotel (Hotel_No, Name, Address) Room (Room_No, Hotel_No, Type, Price) Booking (Hotel_No, Guest_No, Date_From, Date_To, Room_No) Guest (Guest_No, Name, Address)
