-- Keep a log of any SQL queries you execute as you solve the mystery.

--Look for id and description of the crime
SELECT id, description FROM crime_scene_reports WHERE year = 2021 AND month = 7 AND day = 28 AND street = "Humphrey Street";

| 295 | Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery.
Interviews were conducted today with three witnesses who were present
at the time – each of their interview transcripts mentions the bakery. |

| 297 | Littering took place at 16:36. No known witnesses.

--Three witnesses at the moment

SELECT activity, license_plate, hour, minute FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28;
--10:14 There 11 people in the bakery
--FROM 10:16 until 10:35 9 people get out and 2 people remain inside

SELECT activity, license_plate, hour, minute FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour <= 10 AND activity = "entrance";
+----------+---------------+------+--------+
| activity | license_plate | hour | minute |
+----------+---------------+------+--------+
| entrance | 1M92998-      | 8    | 2      |
| entrance | N507616-      | 8    | 2      |
| entrance | 7Z8B130-      | 8    | 7      |
| entrance | 47MEFVA-      | 8    | 13     |
| entrance | D965M59-      | 8    | 15     |
| entrance | HW0488P-      | 8    | 15     |
| entrance |*L93JTIZ       | 8    | 18     |
| entrance |*94KL13X       | 8    | 23     |
| entrance | L68E5I0-      | 8    | 25     |
| entrance | HOD8639-      | 8    | 25     |
| entrance |*1106N58       | 8    | 34     |
| entrance | W2CT78U-      | 8    | 34     |
| entrance |*322W7JE       | 8    | 36     |
| entrance | 3933NUH-      | 8    | 38     |
| entrance |*0NTHK55       | 8    | 42     |
| entrance | 1FBL6TH-      | 8    | 44     |
| entrance | P14PE2Q-      | 8    | 49     |
| entrance | 4V16VO0-      | 8    | 50     |
| entrance | 8LLB02B-      | 8    | 57     |
| entrance | O784M2U-      | 8    | 59     |
| entrance |*4328GD8       | 9    | 14     |
| entrance |*5P2BI95       | 9    | 15     |
| entrance |*6P58WS2       | 9    | 20     |
| entrance |*G412CB7       | 9    | 28     |
| entrance |*R3G7486       | 10   | 8      |
| entrance |*13FNH73       | 10   | 14     |
| entrance | NRYN856       | 10   | 42     |
| entrance | WD5M8I6       | 10   | 44     |
| entrance | V47T75I       | 10   | 55     |
+----------+---------------+------+--------+

SELECT activity, license_plate, hour, minute FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour <= 10 AND activity = "exit";

--Remaining people at the bakery at 10:16

+----------+---------------+------+--------+
| activity | license_plate | hour | minute |
+----------+---------------+------+--------+
| exit     | 1M92998-      | 8    | 2      |
| exit     | N507616-      | 8    | 2      |
| exit     | 7Z8B130-      | 8    | 7      |
| exit     | 47MEFVA-      | 8    | 13     |
| exit     | D965M59-      | 8    | 15     |
| exit     | HW0488P-      | 8    | 15     |
| exit     | HOD8639-      | 8    | 25     |
| exit     | L68E5I0       | 8    | 34     |
| exit     | W2CT78U       | 8    | 34     |
| exit     | 3933NUH       | 8    | 38     |
| exit     | 1FBL6TH       | 8    | 44     |
| exit     | P14PE2Q       | 8    | 49     |
| exit     | 4V16VO0       | 8    | 50     |
| exit     | 8LLB02B       | 8    | 57     |
| exit     | O784M2U       | 8    | 59     |
| exit     | 5P2BI95       | 10   | 16     |
| exit     | 94KL13X       | 10   | 18     |
| exit     | 6P58WS2       | 10   | 18     |
| exit     | 4328GD8       | 10   | 19     |
| exit     | G412CB7       | 10   | 20     |
| exit     | L93JTIZ       | 10   | 21     |
| exit     | 322W7JE       | 10   | 23     |
| exit     | 0NTHK55       | 10   | 23     |
| exit     | 1106N58       | 10   | 35     |
+----------+---------------+------+--------+

SELECT name, transcript FROM interviews WHERE year = 2021 AND month = 7 AND day = 28;

--Name and Transcripts 28/7/2021

+---------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|  name   |                                                                                                                                                     transcript                                                                                                                                                      |
+---------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Jose    | “Ah,” said he, “I forgot that I had not seen you for some weeks. It is a little souvenir from the King of Bohemia in return for my assistance in the case of the Irene Adler papers.”                                                                                                                               |
| Eugene  | “I suppose,” said Holmes, “that when Mr. Windibank came back from France he was very annoyed at your having gone to the ball.”                                                                                                                                                                                      |
| Barbara | “You had my note?” he asked with a deep harsh voice and a strongly marked German accent. “I told you that I would call.” He looked from one to the other of us, as if uncertain which to address.                                                                                                                   |
| Ruth    | Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.                                                          |
| Eugene  | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.                                                                                                 |
| Raymond | As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket. |
| Lily    | Our neighboring courthouse has a very annoying rooster that crows loudly at 6am every day. My sons Robert and Patrick took the rooster to a city far, far away, so it may never bother us again. My sons have successfully arrived in Paris.                                                                        |
+---------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

SELECT * FROM people WHERE license_plate IN  ("322W7JE", "0NTHK55", "1106N58", "L93JTIZ");

--Check people who get out of the bakery ten minutes after license_plate = (322W7JE[10:23], 0NTHK55[10:23], 1106N58[10:35], L93JTIZ[10:21])

+--------+--------+----------------+-----------------+---------------+
|   id   |  name  |  phone_number  | passport_number | license_plate |
+--------+--------+----------------+-----------------+---------------+
| 396669 | Iman   | (829) 555-5269 | 7049073643      | L93JTIZ       |
| 449774 | Taylor | (286) 555-6063 | 1988161715      | 1106N58       |
| 514354 | Diana  | (770) 555-1861 | 3592750733      | 322W7JE       |
| 560886 | Kelsey | (499) 555-9472 | 8294398571      | 0NTHK55       |
+--------+--------+----------------+-----------------+---------------+

SELECT * FROM people WHERE name = "Eugene";

--Check "Eugene" license_plate to look for time she enter to the bakery (before she saw the theft at the ATM)

+--------+--------+----------------+-----------------+---------------+
|   id   |  name  |  phone_number  | passport_number | license_plate |
+--------+--------+----------------+-----------------+---------------+
| 280744 | Eugene | (666) 555-5774 | 9584465633      | 47592FJ       |
+--------+--------+----------------+-----------------+---------------+

SELECT * FROM bakery_security_logs WHERE license_plate = "47592FJ";

-- Eugene didn't go in car to the bakery or she is laying (Suspect)

+-----+------+-------+-----+------+--------+----------+---------------+
| id  | year | month | day | hour | minute | activity | license_plate |
+-----+------+-------+-----+------+--------+----------+---------------+
| 101 | 2021 | 7     | 26  | 13   | 22     | entrance | 47592FJ       |
| 135 | 2021 | 7     | 26  | 17   | 27     | exit     | 47592FJ       |
| 356 | 2021 | 7     | 30  | 8    | 53     | entrance | 47592FJ       |
| 419 | 2021 | 7     | 30  | 15   | 45     | exit     | 47592FJ       |
+-----+------+-------+-----+------+--------+----------+---------------+

SELECT account_number, atm_location, transaction_type, amount FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = "Leggett Street";

--Transactions made in the ATM (the theft withdraw here)

+----------------+----------------+------------------+--------+
| account_number |  atm_location  | transaction_type | amount |
+----------------+----------------+------------------+--------+
| 28500762       | Leggett Street | withdraw         | 48     |
| 28296815       | Leggett Street | withdraw         | 20     |
| 76054385       | Leggett Street | withdraw         | 60     |
| 49610011       | Leggett Street | withdraw         | 50     |
| 16153065       | Leggett Street | withdraw         | 80     |
| 86363979       | Leggett Street | deposit          | 10     |
| 25506511       | Leggett Street | withdraw         | 20     |
| 81061156       | Leggett Street | withdraw         | 30     |
| 26013199       | Leggett Street | withdraw         | 35     |
+----------------+----------------+------------------+--------+

SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = "Leggett Street" AND transaction_type = "withdraw";

--Just account numbers

+----------------+
| account_number |
+----------------+
| 28500762       |
| 28296815       |
| 76054385       |
| 49610011       |
| 16153065       |
| 25506511       |
| 81061156       |
| 26013199       |
+----------------+

SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = "Leggett Street" AND transaction_type = "withdraw");

--ID of people who withdraw in Leggett Street the day of the robbery

+-----------+
| person_id |
+-----------+
| 686048    |
| 514354    |
| 458378    |
| 395717    |
| 396669    |
| 467400    |
| 449774    |
| 438727    |
+-----------+

SELECT * FROM people WHERE id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = "Leggett Street" AND transaction_type = "withdraw"));

--Information of the people who withdraw at Leggerett Street the day of the robbery

+--------+---------+----------------+-----------------+---------------+
|   id   |  name   |  phone_number  | passport_number | license_plate |
+--------+---------+----------------+-----------------+---------------+
| 395717 | Kenny   | (826) 555-1652 | 9878712108      | 30G67EN       |
| 396669 | Iman    | (829) 555-5269 | 7049073643      | L93JTIZ       |
| 438727 | Benista | (338) 555-6650 | 9586786673      | 8X428L0       |
| 449774 | Taylor  | (286) 555-6063 | 1988161715      | 1106N58       |
| 458378 | Brooke  | (122) 555-4581 | 4408372428      | QX4YZN3       |
| 467400 | Luca    | (389) 555-5198 | 8496433585      | 4328GD8       |
| 514354 | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       |
| 686048 | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       |
+--------+---------+----------------+-----------------+---------------+

SELECT activity, license_plate, hour, minute FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND license_plate IN
(SELECT license_plate FROM people WHERE id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = "Leggett Street" AND transaction_type = "withdraw")));

--license_plate of people who withdraw and went to the bakery 28/07/2021

+----------+---------------+------+--------+
| activity | license_plate | hour | minute |
+----------+---------------+------+--------+
| entrance |*L93JTIZ       | 8    | 18     |
| entrance |*94KL13X       | 8    | 23     |
| entrance |*1106N58       | 8    | 34     |
| entrance |*322W7JE       | 8    | 36     |
| entrance |*4328GD8       | 9    | 14     |
| exit     | 94KL13X       | 10   | 18     |
| exit     | 4328GD8       | 10   | 19     |
| exit     | L93JTIZ       | 10   | 21     |
| exit     | 322W7JE       | 10   | 23     |
| exit     | 1106N58       | 10   | 35     |
+----------+---------------+------+--------+

SELECT * FROM people WHERE id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = "Leggett Street" AND transaction_type = "withdraw")) AND license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND license_plate IN
(SELECT license_plate FROM people WHERE id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = "Leggett Street" AND transaction_type = "withdraw"))));

--People who withdraw and went to the bakery 28/07/2021

+--------+--------+----------------+-----------------+---------------+
|   id   |  name  |  phone_number  | passport_number | license_plate |
+--------+--------+----------------+-----------------+---------------+
| 396669 | Iman   | (829) 555-5269 | 7049073643      | L93JTIZ       |
| 449774 | Taylor | (286) 555-6063 | 1988161715      | 1106N58       |CALL 10:35 - exit
| 467400 | Luca   | (389) 555-5198 | 8496433585      | 4328GD8       |
| 514354 | Diana  | (770) 555-1861 | 3592750733      | 322W7JE       |CALL 10:23 - exit
| 686048 | Bruce  | (367) 555-5533 | 5773159633      | 94KL13X       |CALL 10:18 - exit
+--------+--------+----------------+-----------------+---------------+

SELECT caller, receiver, duration FROM phone_calls  WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60 AND  caller IN
(SELECT phone_number FROM people WHERE id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = "Leggett Street" AND transaction_type = "withdraw")) AND license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND license_plate IN
(SELECT license_plate FROM people WHERE id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = "Leggett Street" AND transaction_type = "withdraw")))));

--Calls people who witdraw and went to the bakery (duration less than 1 minutes)

+----------------+----------------+----------+
|     caller     |    receiver    | duration |
+----------------+----------------+----------+
| (367) 555-5533 | (375) 555-8161 | 45       |BRUCE
| (286) 555-6063 | (676) 555-6554 | 43       |TAYLOR
| (770) 555-1861 | (725) 555-3243 | 49       |
+----------------+----------------+----------+

SELECT caller, receiver, duration FROM phone_calls  WHERE year = 2021 AND month = 7 AND day = 28 AND  receiver IN
(SELECT phone_number FROM people WHERE id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = "Leggett Street" AND transaction_type = "withdraw")) AND license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND license_plate IN
(SELECT license_plate FROM people WHERE id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = "Leggett Street" AND transaction_type = "withdraw")))));

--Receive calls people who witdraw and went to the bakery

+----------------+----------------+----------+
|     caller     |    receiver    | duration |
+----------------+----------------+----------+
| (544) 555-8087 | (389) 555-5198 | 595      |
| (609) 555-5876 | (389) 555-5198 | 60       |
| (068) 555-0183 | (770) 555-1861 | 371      |
+----------------+----------------+----------+

SELECT * FROM airports WHERE city = "Fiftyville";

-- Airpot in Fiftyville

+----+--------------+-----------------------------+------------+
| id | abbreviation |          full_name          |    city    |
+----+--------------+-----------------------------+------------+
| 8  | CSF          | Fiftyville Regional Airport | Fiftyville |
+----+--------------+-----------------------------+------------+

SELECT * FROM flights WHERE year = 2021 AND month = 7 AND day = 29 AND origin_airport_id = (SELECT id FROM airports WHERE city = "Fiftyville") ORDER BY hour ASC LIMIT 1;

--Flights from  Fiftyville 29/07/2021

+----+-------------------+------------------------+------+-------+-----+------+--------+
| id | origin_airport_id | destination_airport_id | year | month | day | hour | minute |
+----+-------------------+------------------------+------+-------+-----+------+--------+
| 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     |
+----+-------------------+------------------------+------+-------+-----+------+--------+

SELECT * FROM airports WHERE id = (SELECT destination_airport_id FROM flights WHERE year = 2021 AND month = 7 AND day = 29 AND origin_airport_id = (SELECT id FROM airports WHERE city = "Fiftyville") ORDER BY hour ASC LIMIT 1);

--Destination of the Thief

+----+--------------+-------------------+---------------+
| id | abbreviation |     full_name     |     city      |
+----+--------------+-------------------+---------------+
| 4  | LGA          | LaGuardia Airport | New York City |
+----+--------------+-------------------+---------------+


SELECT * FROM passengers WHERE flight_id IN (SELECT id FROM flights WHERE year = 2021 AND month = 7 AND day = 29 AND origin_airport_id = (SELECT id FROM airports WHERE city = "Fiftyville") ORDER BY hour ASC LIMIT 1) AND passport_number IN (SELECT passport_number FROM people WHERE phone_number IN
(SELECT caller FROM phone_calls  WHERE year = 2021 AND month = 7 AND day = 28 AND  caller IN (SELECT phone_number FROM people WHERE id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = "Leggett Street" AND transaction_type = "withdraw")) AND license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND license_plate IN (SELECT license_plate FROM people WHERE id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = "Leggett Street" AND transaction_type = "withdraw")))))));

--Passport of people who witdraw and went to the bakery and call less than 1 minute and took a flight the next day of the robbery

+-----------+-----------------+------+
| flight_id | passport_number | seat |
+-----------+-----------------+------+
| 36        | 5773159633      | 4A   | BRUCE (367) 555-5533 94KL13X
| 36        | 1988161715      | 6D   | TAYLOR (286) 555-6063 1106N58
+-----------+-----------------+------+

SELECT * FROM passengers WHERE flight_id IN (SELECT id FROM flights WHERE year = 2021 AND month = 7 AND day = 29 AND origin_airport_id = (SELECT id FROM airports WHERE city = "Fiftyville") ORDER BY hour ASC LIMIT 1)

--All passengers in the flight of BRUCE and TAYLOR

+-----------+-----------------+------+
| flight_id | passport_number | seat |
+-----------+-----------------+------+
| 36        | 7214083635      | 2A   |
| 36        | 1695452385      | 3B   |
| 36        | 5773159633      | 4A   |
| 36        | 1540955065      | 5C   |
| 36        | 8294398571      | 6C   |
| 36        | 1988161715      | 6D   |
| 36        | 9878712108      | 7A   |
| 36        | 8496433585      | 7B   |
+-----------+-----------------+------+

SELECT * FROM people WHERE license_plate IN (SELECT DISTINCT(license_plate) FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28) AND passport_number IN
(SELECT passport_number FROM passengers WHERE flight_id IN (SELECT id FROM flights WHERE year = 2021 AND month = 7 AND day = 29 AND origin_airport_id = (SELECT id FROM airports WHERE city = "Fiftyville") ORDER BY hour ASC LIMIT 1));

--All suspects of the roberry

+--------+--------+----------------+-----------------+---------------+
|   id   |  name  |  phone_number  | passport_number | license_plate |
+--------+--------+----------------+-----------------+---------------+
| 398010 | Sofia  | (130) 555-0289 | 1695452385      | G412CB7       |
| 449774 | Taylor | (286) 555-6063 | 1988161715      | 1106N58       | Main Thief? CALL 10:35 - exit
| 467400 | Luca   | (389) 555-5198 | 8496433585      | 4328GD8       |
| 560886 | Kelsey | (499) 555-9472 | 8294398571      | 0NTHK55       |
| 686048 | Bruce  | (367) 555-5533 | 5773159633      | 94KL13X       | Main Thief? CALL 10:18 - exit
+--------+--------+----------------+-----------------+---------------+

SELECT * FROM people WHERE id IN (SELECT person_id FROM bank_accounts WHERE account_number IN
(SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = "Leggett Street" AND transaction_type = "withdraw"));

+--------+---------+----------------+-----------------+---------------+
|   id   |  name   |  phone_number  | passport_number | license_plate |
+--------+---------+----------------+-----------------+---------------+
| 395717 | Kenny   | (826) 555-1652 | 9878712108      | 30G67EN       |
| 396669 | Iman    | (829) 555-5269 | 7049073643      | L93JTIZ       |
| 438727 | Benista | (338) 555-6650 | 9586786673      | 8X428L0       |
| 449774 | Taylor  | (286) 555-6063 | 1988161715      | 1106N58       |
| 458378 | Brooke  | (122) 555-4581 | 4408372428      | QX4YZN3       |
| 467400 | Luca    | (389) 555-5198 | 8496433585      | 4328GD8       |
| 514354 | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       |
| 686048 | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       |
+--------+---------+----------------+-----------------+---------------+

SELECT * FROM people WHERE passport_number IN (SELECT passport_number FROM passengers WHERE flight_id IN (SELECT id FROM flights WHERE year = 2021 AND month = 7 AND day = 29 AND origin_airport_id = (SELECT id FROM airports WHERE city = "Fiftyville") ORDER BY hour ASC LIMIT 1));

--All people in the flight

+--------+--------+----------------+-----------------+---------------+
|   id   |  name  |  phone_number  | passport_number | license_plate |
+--------+--------+----------------+-----------------+---------------+
| 395717 | Kenny  | (826) 555-1652 | 9878712108      | 30G67EN       |
| 398010 | Sofia  | (130) 555-0289 | 1695452385      | G412CB7       |
| 449774 | Taylor | (286) 555-6063 | 1988161715      | 1106N58       |
| 467400 | Luca   | (389) 555-5198 | 8496433585      | 4328GD8       |
| 560886 | Kelsey | (499) 555-9472 | 8294398571      | 0NTHK55       |
| 651714 | Edward | (328) 555-1152 | 1540955065      | 130LD9Z       |
| 686048 | Bruce  | (367) 555-5533 | 5773159633      | 94KL13X       |
| 953679 | Doris  | (066) 555-9701 | 7214083635      | M51FA04       |
+--------+--------+----------------+-----------------+---------------+

SELECT * FROM people WHERE phone_number = "(676) 555-6554"

+--------+-------+----------------+-----------------+---------------+
|   id   | name  |  phone_number  | passport_number | license_plate |
+--------+-------+----------------+-----------------+---------------+
| 250277 | James | (676) 555-6554 | 2438825627      | Q13SVG6       |
+--------+-------+----------------+-----------------+---------------+

SELECT * FROM people WHERE phone_number = "(375) 555-8161"

+--------+-------+----------------+-----------------+---------------+
|   id   | name  |  phone_number  | passport_number | license_plate |
+--------+-------+----------------+-----------------+---------------+
| 864400 | Robin | (375) 555-8161 |                 | 4V16VO0       |
+--------+-------+----------------+-----------------+---------------+