module Homework1 where
import Test.Hspec -- <- DO NOT REMOVE THIS
-- Function prob1
-- @type   
-- @param  Char
-- @output Char
-- @description: we use a combination of the elem and succ prelude functions to accomplish this. First we check if the Char is either a 'z' or 'Z' as succ will not wrap around. After checking those two conditions, we simply check to see if the char is in the list of 'A'..'Y' or 'a'..'y'. If so, we can just use the succ function on it to get the right answer.
prob1 :: Char -> Char
prob1 x
  | x == 'z' = 'a'
  | x == 'Z' = 'A'
  | elem x ['a'..'z'] = succ(x) 
  | elem x ['A'..'Z'] = succ(x)
  | otherwise = x
-- Function prob2
-- @type   
-- @param  Char
-- @output Int
-- @description: problem 2 is takes in a char and outputs an Int. for this we check if the input is an element of 0..9, which is a list of possible number values. If it is, we use the read function to print the inputted char as an Int. If it isn't an element of the list, use otherwise to return a -1
prob2 :: Char -> Int
prob2 x 
  | x `elem` ['0'..'9'] = read [x] :: Int
  | otherwise = -1

-- Function prob3
-- @type   
-- @param  function of type a -> b
-- @param  function of type a -> c
-- @param  input of type a
-- @output tuple of type (b, c)
-- @description: takes in two different functions and an  arg and applies both functions to the arguement. As we didn't cover map yet, we returned the two functions and the arg as a tuple.
prob3 :: (a->b) -> (a->c) -> a -> (b,c)
prob3 func1 func2 arg = (func1 arg, func2 arg)
-- prob4
-- @type   
-- @param  Bool
-- @param  input of type a
-- @param  input of type a
-- @output output of type a
-- @description: we use guards to check if the Bool(n) is true or false. If it's true, it'll return the first arguement (m), and if false (or otherwise) the o.
prob4 :: Bool -> a -> a -> a
prob4 n m o 
  | n = m
  | otherwise = o

-- prob5
-- @type   
-- @param  Integer
-- @output Bool
-- @description: leap years are found in two different occasions: if it's a product of four and NOT a product of 100 or if it's a product of four, a product of 100 and a product of 400. We used guards to check these two conditions. If it didn't meet this, we used the otherwise to return a false.
prob5 :: Int -> Bool
prob5 x
  | mod x 4 == 0 && mod x 100 /= 0  = True
  | mod x 4 == 0 && mod x 100 == 0 && mod x 400 ==0 = True
  | otherwise = False

-- All Unit Tests Below This Line --
-- Don't touch anything below this line
test_prob1 :: IO ()
test_prob1 = hspec $ do
  describe "prob1" $ do
    it "returns \'A\' when given \'Z\'" $
      prob1 'Z' `shouldBe` 'A'

    it "returns \'a\' when given \'z\'" $
      prob1 'z' `shouldBe` 'a'

    it "returns the next letter" $
      (map prob1 ['a'..'y']) `shouldBe` ['b'..'z']

    it "returns the input unchanged for non-letters" $
      prob1 '1' `shouldBe` '1'

test_prob2 :: IO ()
test_prob2 = hspec $ do
  describe "prob2" $ do
    it "returns the corresponding value when given a digit" $
       (map prob2 ['0'..'9']) `shouldBe` [0..9]

    it "returns -1 when given a control character" $
      prob2 '\n' `shouldBe` (-1)

    it "returns -1 when given an escape character" $
      prob2 '\\' `shouldBe` (-1)

    it "returns -1 when given a non-digit" $
      prob2 'a' `shouldBe` (-1)

test_prob3 :: IO ()
test_prob3 = hspec $ do
  describe "prob3" $ do
    it "returns (\'b\',-1) given prob1 prob2 \'a\'" $
      prob3 prob1 prob2 'a' `shouldBe` ('b',-1)

    it "returns (\'c\',-1) given (prob1 . prob1) (prob2 . prob1) \'a\'" $
      prob3 (prob1 . prob1) (prob2 . prob1) 'a' `shouldBe` ('c',-1)

    it "returns (\\,-1) when given an escape character" $
      prob3 prob1 prob2 '\\' `shouldBe` ('\\',-1)

    it "returns (\'a\',\'a\') given id id \'a\'" $
      prob3 id id 'a' `shouldBe` ('a','a')

test_prob4 :: IO ()
test_prob4 = hspec $ do
  describe "prob4" $ do
    it "returns \"true\" given True \"true\" \"false\"" $
      prob4 True "true" "false" `shouldBe` "true"

    it "returns \"false\" given False \"true\" \"false\"" $
      prob4 False "true" "false" `shouldBe` "false"

    it "returns \"true\" given (0 == 0) \"true\" \"false\"" $
      prob4 (0 == 0) "true" "false" `shouldBe` "true"

    it "returns \"false\" given (0 /= 0) \"true\" \"false\"" $
      prob4 (0 /= 0) "true" "false" `shouldBe` "false"

test_prob5 :: IO ()
test_prob5 = hspec $ do
  describe "prob5" $ do
    let leapYears = [1804, 1808, 1812, 1816, 1820, 1824, 1828, 1832, 1836, 1840, 1844, 1848, 1852, 1856, 1860, 1864, 1868, 1872, 1876, 1880, 1884, 1888, 1892, 1896, 1904, 1908, 1912, 1916, 1920, 1924, 1928, 1932, 1936, 1940, 1944, 1948, 1952, 1956, 1960, 1964, 1968, 1972, 1976, 1980, 1984, 1988, 1992, 1996, 2000, 2004, 2008, 2012, 2016]
    let commonYears = [1800,1801,1802,1803,1805,1806,1807,1809,1810,1811,1813,1814,1815,1817,1818,1819,1821,1822,1823,1825,1826,1827,1829,1830,1831,1833,1834,1835,1837,1838,1839,1841,1842,1843,1845,1846,1847,1849,1850,1851,1853,1854,1855,1857,1858,1859,1861,1862,1863,1865,1866,1867,1869,1870,1871,1873,1874,1875,1877,1878,1879,1881,1882,1883,1885,1886,1887,1889,1890,1891,1893,1894,1895,1897,1898,1899,1900,1901,1902,1903,1905,1906,1907,1909,1910,1911,1913,1914,1915,1917,1918,1919,1921,1922,1923,1925,1926,1927,1929,1930,1931,1933,1934,1935,1937,1938,1939,1941,1942,1943,1945,1946,1947,1949,1950,1951,1953,1954,1955,1957,1958,1959,1961,1962,1963,1965,1966,1967,1969,1970,1971,1973,1974,1975,1977,1978,1979,1981,1982,1983,1985,1986,1987,1989,1990,1991,1993,1994,1995,1997,1998,1999,2001,2002,2003,2005,2006,2007,2009,2010,2011,2013,2014,2015,2017]
    it "returns False given 1900" $
      prob5 1900 `shouldBe` False

    it "returns True given 2000" $
      prob5 2000 `shouldBe` True

    it "returns True for leap years 1800-2017" $
      all prob5 leapYears `shouldBe` True

    it "returns False for common years 1800-2017" $
      all (not . prob5) commonYears `shouldBe` True

test_all_probs :: IO ()
test_all_probs = do
  test_prob1
  test_prob2
  test_prob3
  test_prob4
  test_prob5


                     
