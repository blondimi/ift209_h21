#include <iostream>

unsigned long somme(unsigned long x, unsigned long y)
{
  return x + y;
}

unsigned long produit(unsigned long x, unsigned long y)
{
  return x * y;
}

unsigned long diff(unsigned long x, unsigned long y)
{
  return x - y;
}

int main()
{
  unsigned long (*tab[])(unsigned long, unsigned long) = {&somme,
                                                          &produit,
                                                          &diff};
  unsigned long x = 7;
  unsigned long y = 5;
  unsigned int  i;

  std::cin >> i;
  std::cout << (*tab[i])(x, y) << std::endl;
}
