-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 17, 2023 at 08:44 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codeup`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(100) NOT NULL,
  `name` text NOT NULL,
  `phone_num` varchar(100) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `phone_num`, `msg`, `date`, `email`) VALUES
(1, 'Test_name', '1234567891', 'Hey, checking db', '2023-10-15 17:42:57', 'temp@mail.com'),
(2, 'test', '1231231231', 'hey!!', '2023-10-15 17:42:57', 'test@gmail.com'),
(3, 'test2', '1231231231', 'hey what is the date now', '2023-10-15 18:39:44', 'testing@gmail.com'),
(4, 'test3', '1231231231', 'Hey!!!', '2023-10-15 19:09:25', 'h@gmail.com'),
(5, 'Rahul', '1231231231', 'Hey, do you get my mail?', '2023-10-16 10:08:07', 'rahul@maill.com'),
(6, 'Rahul', '1231231231', 'Hey, do you get my mail?', '2023-10-16 10:10:19', 'rahul@maill.com'),
(7, 'Rahul', '1231231231', 'Hey, do you get my mail?', '2023-10-16 10:11:07', 'a.k.orton.ako@gmail.com'),
(8, 'Rahul', '1231231231', 'Hey, do you get my mail?', '2023-10-16 10:14:31', 'a.k.orton.ako@gmail.com'),
(9, 'Rahul', '1231231231', 'Hey, do you get my mail?', '2023-10-16 10:17:15', 'a.k.orton.ako@gmail.com'),
(15, 'Akki', '1231231231', 'Hi Admin, can we connect?', '2023-10-17 10:26:36', 'a.k.orton.ako@gmail.com'),
(16, 'Akk', '', '', '2023-10-17 10:27:40', ''),
(17, 'Akki', '1231231231', 'Hiii', '2023-10-17 10:28:51', 'a.k.orton.ako@gmail.com'),
(18, 'Akki', '1231231231', 'Hello', '2023-10-17 10:30:36', 'a.k.orton.ako@gmail.com'),
(19, 'Akki', '1231231231', 'h', '2023-10-17 10:33:11', 'a.k.orton.ako@gmail.com'),
(20, 'Akki', '1231231231', 'H', '2023-10-17 10:34:44', 'a.k.orton.ako@gmail.com'),
(21, 'Akki', '1231231231', 'h', '2023-10-17 10:35:57', 'a.k.orton.ako@gmail.com'),
(22, 'Akshay Kumar', '1231231231', 'H', '2023-10-17 10:37:49', 'akshaykumar.ak603@gmail.com'),
(23, 'Akki', '1231231231', 'H', '2023-10-17 10:44:18', 'a.k.orton.ako@gmail.com'),
(24, 'Akshay Kumar', '1231231231', 'H', '2023-10-17 10:45:10', 'akshaykumar.ak603@gmail.com'),
(25, 'Akki', '1231231231', 'Hry', '2023-10-17 10:45:57', 'a.k.orton.ako@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `slug` varchar(30) NOT NULL,
  `img_file` varchar(50) DEFAULT 'about-bg.jpg',
  `subheading` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `slug`, `img_file`, `subheading`, `content`, `date`) VALUES
(1, 'Learn Stock Market', 'post-learn-stock', 'post-bg.jpg', 'Here we will discuss key concepts of stock market.', 'A stock market, equity market, or share market is the aggregation of buyers and sellers of stocks (also called shares), which represent ownership claims on businesses; these may include securities listed on a public stock exchange, as well as stock that is only traded privately, such as shares of private companies which are sold to investors through equity crowdfunding platforms. Investment is usually made with an investment strategy in mind.', '2023-10-16 17:21:16'),
(2, 'Lakes of Journey', 'post-2', 'about-bg.jpg', 'Lets explore the lakes around the world', 'A lake is a naturally occurring, relatively large body of water localized in a basin or interconnected basins surrounded by dry land. Lakes lie completely on land and are separate from the ocean, although, like the much larger oceans, they form part of the Earth\'s water cycle by serving as large standing pools of storage water. Most lakes are freshwater and account for almost all the world\'s surface freshwater, but some are salt lakes with salinities even higher than that of seawater.\r\n\r\nLakes are typically much larger and deeper than ponds, which are also water-filled basins on land, although there are no official definitions or scientific criteria distinguishing the two. Most lakes are fed by springs, and both fed and drained by creeks and rivers, but some lakes are endorheic without any outflow, while volcanic lakes are filled directly by precipitation runoffs and do not have any inflow streams.', '2023-10-16 21:25:07'),
(3, 'Dogs are Faith', 'post-3', 'about-bg.jpg', 'Dog\'s prespective of living', 'It must be morning; I’m hungry. Then again, I’m always hungry, so it could really be any time. I can hear the shower and feel the sun on my back, so I’m guessing the Boss is awake. I lift my head off my bed and look down the passage . I want a shower too. Sometimes I try and get in but he won’t let me. Boring. He’s not so happy in the mornings any more. He used to be, but things have changed. I think it’s stress.  Not really sure what that is, but I know it’s not good. It’s a human thing. I’ve heard him talk about it on the phone. Don’t really know what a phone is either, but I know they’re good to chew. Chewing’s one of my favourite things.  In the old days we wrestled every morning. He’d pull my ears and I’d jump on his head. These days, not so much. Before he went to work, we’d play ball. After work too. He’d throw, I’d fetch. He’d throw, I’d fetch. Forever. What an amazing game. Such fun. He’d laugh and talk human. I’d growl. I’d laugh if I could. Mostly, I’d just wag my tail. I think it’s sad that humans don’t have tails. Sometimes he’d lose focus, so I would nudge him. Maybe a little nip on the hand just to keep his head in the game. How much fun can one Golden Retriever and one human have?  But lately he seems grumpy.', '2023-10-16 11:31:37'),
(4, 'What is Love...', 'post-4', 'about-bg.jpg', 'Love is same in every language.', 'Love encompasses a range of strong and positive emotional and mental states, from the most sublime virtue or good habit, the deepest interpersonal affection, to the simplest pleasure. An example of this range of meanings is that the love of a mother differs from the love of a spouse, which differs from the love for food. Most commonly, love refers to a feeling of strong attraction and emotional attachment.', '2023-10-16 11:35:16'),
(5, 'Coding Verse', 'coding-evolution', 'about-bg.jpg', 'Evolution of coding right now.', 'Computer programming is the process of performing particular computations (or more generally, accomplishing specific computing results), usually by designing and building executable computer programs. Programming involves tasks such as analysis, generating algorithms, profiling algorithms\' accuracy and resource consumption, and the implementation of algorithms (usually in a particular programming language, commonly referred to as coding).', '2023-10-16 15:56:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
