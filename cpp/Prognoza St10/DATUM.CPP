#include <stdlib.h>
#include <string.h>
#include "datum.h"

char year[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
     cros[12] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

date operator +=(int i)
{
  da_day += i;
  if ((((da_year%4) == 0) && (da_day > cros[da_mon-1])) ||
      (((da_year%4) != 0) && (da_day > year[da_mon-1])))
  {
    da_day = 1;
    da_mon++;
  }
  if (da_mon > 12)
  {
    da_mon = 1;
    da_year++;
  }
  return this;
}

date ascii2date (char *ad)
{
  date d;
  char *t;

  t = ad;
  d.da_day = atoi (t);
  t = strchr (t, '.') + 1;
  d.da_mon = atoi (t);
  t = strchr (t, '.') + 1;
  d.da_year = atoi (t) - 1980;
  return d;
}

void date2ascii (char *ad, date d)
{
  char tmp[5];

  itoa (d.da_day, tmp, 10);
  strcpy (ad, tmp);
  strcat (ad, ".");
  itoa (d.da_mon, tmp, 10);
  strcat (ad, tmp);
  strcat (ad, ".");
  itoa (d.da_year+1980, tmp, 10);
  strcat (ad, tmp);
}