-- ============================================================================
-- IPL TICKET BOOKING WEB APPLICATION - DATABASE SCHEMA & SAMPLE DATA
-- Database File: App_Data\ipl_ticket_booking.mdb (MS Access 2000/2002-2003 format)
-- ============================================================================

-- 1. USERS TABLE (Login & Role Management)
CREATE TABLE Users (
    UserId AUTOINCREMENT PRIMARY KEY,
    Username TEXT(50) NOT NULL,
    [Password] TEXT(50) NOT NULL,
    Role TEXT(20) NOT NULL,
    FullName TEXT(100),
    Email TEXT(100),
    Phone TEXT(20)
);

-- 2. CUSTOMERS TABLE (User Screen 1: Customer Form CRUD)
CREATE TABLE Customers (
    CustomerId AUTOINCREMENT PRIMARY KEY,
    FullName TEXT(100) NOT NULL,
    Email TEXT(100) NOT NULL,
    Phone TEXT(20) NOT NULL,
    City TEXT(50) NOT NULL
);

-- 3. MATCH DETAILS TABLE (Admin Screen 3: Match Form CRUD)
CREATE TABLE MatchDetails (
    MatchId AUTOINCREMENT PRIMARY KEY,
    MatchName TEXT(100) NOT NULL,
    TeamA TEXT(50) NOT NULL,
    TeamB TEXT(50) NOT NULL,
    Venue TEXT(100) NOT NULL,
    MatchDate DATETIME NOT NULL
);

-- 4. STAND DETAILS TABLE (Admin Screen 4: Stand Form CRUD)
CREATE TABLE StandDetails (
    StandId AUTOINCREMENT PRIMARY KEY,
    MatchId LONG NOT NULL REFERENCES MatchDetails(MatchId),
    StandName TEXT(50) NOT NULL,
    Price CURRENCY NOT NULL,
    TotalSeats LONG NOT NULL
);

-- 5. SEAT DETAILS TABLE (Admin Screen 5: Seat Form CRUD)
CREATE TABLE SeatDetails (
    SeatId AUTOINCREMENT PRIMARY KEY,
    StandId LONG NOT NULL REFERENCES StandDetails(StandId),
    SeatNumber TEXT(20) NOT NULL,
    Price CURRENCY NOT NULL,
    IsBooked YESNO DEFAULT 0
);

-- 6. BOOKINGS TABLE (User Screen 2: Booking Form CRUD)
CREATE TABLE Bookings (
    BookingId AUTOINCREMENT PRIMARY KEY,
    CustomerId LONG NOT NULL REFERENCES Customers(CustomerId),
    MatchId LONG NOT NULL REFERENCES MatchDetails(MatchId),
    StandId LONG NOT NULL REFERENCES StandDetails(StandId),
    SeatId LONG NOT NULL REFERENCES SeatDetails(SeatId),
    TicketCount LONG NOT NULL,
    TotalAmount CURRENCY NOT NULL,
    BookingDate DATETIME NOT NULL
);

-- ============================================================================
-- SAMPLE SEED DATA
-- ============================================================================

INSERT INTO Users (Username, [Password], Role, FullName, Email, Phone) VALUES ('admin', 'admin123', 'Admin', 'Administrator', 'admin@ipl.com', '9876543210');
INSERT INTO Users (Username, [Password], Role, FullName, Email, Phone) VALUES ('user1', 'user123', 'User', 'Rahul Sharma', 'rahul@gmail.com', '9123456789');

INSERT INTO Customers (FullName, Email, Phone, City) VALUES ('Rahul Sharma', 'rahul@gmail.com', '9123456789', 'Chennai');
INSERT INTO Customers (FullName, Email, Phone, City) VALUES ('Priya Patel', 'priya@gmail.com', '9988776655', 'Mumbai');

INSERT INTO MatchDetails (MatchName, TeamA, TeamB, Venue, MatchDate) VALUES ('CSK vs MI - Match 01', 'CSK', 'MI', 'MA Chidambaram Stadium, Chennai', #2026-04-15 19:30:00#);
INSERT INTO MatchDetails (MatchName, TeamA, TeamB, Venue, MatchDate) VALUES ('RCB vs KKR - Match 02', 'RCB', 'KKR', 'Chinnaswamy Stadium, Bengaluru', #2026-04-16 19:30:00#);

INSERT INTO StandDetails (MatchId, StandName, Price, TotalSeats) VALUES (1, 'North VIP Stand', 3500, 50);
INSERT INTO StandDetails (MatchId, StandName, Price, TotalSeats) VALUES (1, 'South Upper Stand', 1500, 100);
INSERT INTO StandDetails (MatchId, StandName, Price, TotalSeats) VALUES (2, 'Grand Pavilion', 4000, 60);

INSERT INTO SeatDetails (StandId, SeatNumber, Price, IsBooked) VALUES (1, 'N-101', 3500, 0);
INSERT INTO SeatDetails (StandId, SeatNumber, Price, IsBooked) VALUES (1, 'N-102', 3500, 0);
INSERT INTO SeatDetails (StandId, SeatNumber, Price, IsBooked) VALUES (2, 'S-201', 1500, 0);
INSERT INTO SeatDetails (StandId, SeatNumber, Price, IsBooked) VALUES (3, 'G-301', 4000, 0);

INSERT INTO Bookings (CustomerId, MatchId, StandId, SeatId, TicketCount, TotalAmount, BookingDate) VALUES (1, 1, 1, 1, 2, 7000, #2026-04-01 10:00:00#);
