import 'package:watermaniac/model/water/Drink.dart';

class Glass {
  int waterAmountTarget;
  int currentWaterAmount;

  Glass(this.waterAmountTarget, this.currentWaterAmount);

  Glass addDrink(Drink drink) {
    return Glass(this.waterAmountTarget, this.currentWaterAmount + drink.amount);
  }

  Glass removeDrink(Drink drink) {
    return Glass(this.waterAmountTarget, this.currentWaterAmount - drink.amount);
  }
}