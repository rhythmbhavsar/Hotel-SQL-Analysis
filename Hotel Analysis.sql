-- List full details of all hotels.
SELECT * FROM Hotel; 

-- List full details of all hotels in London.
SELECT * FROM Hotel WHERE city = ‘London’; 

-- List the names and addresses of all guests in London, alphabetically ordered by name.
SELECT name, address FROM guest WHERE address like '%London%' ORDER BY name;

-- List all double or family rooms with a price below £40.00 per night, in ascending order of price.
SELECT * FROM room WHERE price < 40 AND type IN (‘D’, ‘F’) ORDER BY price; 

-- List the bookings for which no dateTo has been specified.
SELECT * FROM Booking WHERE dateTo IS NULL;

-- How many hotels are there?
SELECT COUNT(*) FROM Hotel;

-- What is the average price of a room?
SELECT AVG(price) FROM Room;

-- What is the total revenue per night from all double rooms?
SELECT SUM(price) FROM Room WHERE type = ‘D’;

-- How many different guests have made bookings for August?
SELECT COUNT(DISTINCT guestNo) FROM Booking
WHERE (dateFrom <= DATE’2004-08-01’ AND dateTo >= DATE’2004-08-01’) OR
(dateFrom >= DATE’2004-08-01’ AND dateFrom <= DATE’2004-08-31’);

-- List the price and type of all rooms at the Grosvenor Hotel.
SELECT price, type FROM Room WHERE hotelNo = (SELECT hotelNo FROM Hotel WHERE hotelName = 'Grosvenor Hotel'); 

-- List all guests currently staying at the Grosvenor Hotel.
SELECT * FROM Guest
WHERE guestNo =
(SELECT guestNo FROM Booking WHERE dateFrom <= CURRENT_DATE AND
dateTo >= CURRENT_DATE AND
hotelNo = (SELECT hotelNo FROM Hotel
WHERE hotelName = 'Grosvenor Hotel'));

-- List the details of all rooms at the Grosvenor Hotel, including the name of the guest staying in the room, if the room is occupied 
SELECT r.* FROM Room r LEFT JOIN
 (SELECT g.guestName, h.hotelNo, b.roomNo FROM Guest g, Booking b, Hotel h
 WHERE g.guestNo = b.guestNo AND b.hotelNo = h.hotelNo AND
 hotelName= 'Grosvenor Hotel' AND
 dateFrom <= CURRENT_DATE AND
 dateTo >= CURRENT_DATE) AS XXX
 ON r.hotelNo = XXX.hotelNo AND r.roomNo = XXX.roomNo; 
 
 -- What is the total income from bookings for the Grosvenor Hotel today ?
SELECT SUM(price)
FROM booking b, room r, hotel h
WHERE (b.datefrom <= 'SYSTEM DATE'
AND b.dateto >= 'SYSTEM DATE')
AND r.hotelno = h.hotelno
AND r.hotelno = b.hotelno
AND r.roomno = b.roomno
AND h.hotelname = 'Grosvenor';

-- List the rooms which are currently unoccupied at the Grosvenor Hotel.
SELECT (r.hotelno, r.roomno, r.type, r.price)
FROM room r, hotel h
WHERE r.hotelno = h.hotelno AND
h.hotelname = 'Grosvenor' AND
roomno NOT IN
(SELECT roomno
FROM booking b, hotel h
WHERE (datefrom <= 'SYSTEM DATE'
AND dateto >= 'SYSTEM DATE')
AND b.hotelno=h.hotelno
AND hotelname = 'Grosvenor');

-- What is the lost income from unoccupied rooms at the Grosvenor Hotel?
SELECT SUM(price)
FROM room r, hotel h
WHERE r.hotelno = h.hotelno AND
h.hotelname = 'Grosvenor' AND
roomno NOT IN
(SELECT roomno FROM booking b, hotel h
WHERE (datefrom <= 'SYSTEM DATE'
AND dateto >= 'SYSTEM DATE') AND
b.hotelno = h.hotelno
AND r.hotelno=b.hotelno
AND r.roomno=b.roomno
AND h.hotelname = 'Grosvenor');

-- List the number of rooms in each hotel.
SELECT hotelNo, COUNT(roomNo) AS count FROM Room GROUP BY hotelNo; 

-- List the number of rooms in each hotel in London.
SELECT hotelNo, COUNT(roomNo) AS count FROM Room r, Hotel h WHERE r.hotelNo = h.hotelNo AND city = ‘London’ GROUP BY hotelNo; 

-- What is the average number of bookings for each hotel in August?
SELECT hotelno, y/31
FROM
(SELECT hotelno, COUNT(hotelno) AS y
FROM booking
WHERE (datefrom <= '8/31/06' AND
dateto >= '8/1/06' )
GROUP BY hotelno);

-- What is the most commonly booked room type for all hotels in London?
SELECT type, MAX(y)
FROM
(SELECT type, COUNT(type) AS y
FROM booking b, hotel h, room r
WHERE r.roomno = b.roomno AND
r.hotelno = b.hotelno AND
b.hotelno = h.hotelno AND
city = 'London'
GROUP BY type)
GROUP BY type;

-- What is the lost income from unoccupied rooms at each hotel today?
SELECT r.hotelno, SUM(price)
FROM room r
WHERE NOT exists (SELECT * FROM booking b WHERE
r.roomno = b.roomno AND
r.hotelno = b.hotelno AND
(datefrom <= 'SYSTEM DATE' AND
dateto >= 'SYSTEM DATE'))
GROUP BY hotelno;