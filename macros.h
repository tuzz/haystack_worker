#define F(index) \
  for (attempt[index] =  ranges[index][0]; \
       attempt[index] <= ranges[index][1]; \
       attempt[index]++)

#define YIELD_ATTEMPTS \
  int attempt[26]; \
  F(0)  F(1)  F(2)  F(3)  F(4)  F(5)  F(6) \
  F(7)  F(8)  F(9)  F(10) F(11) F(12) F(13) \
  F(14) F(15) F(16) F(17) F(18) F(19) F(20) \
  F(21) F(22) F(23) F(24) F(25)
