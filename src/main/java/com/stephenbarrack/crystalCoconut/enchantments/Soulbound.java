package com.stephenbarrack.crystalCoconut.enchantments;

import net.minecraft.enchantment.Enchantment;
import net.minecraft.enchantment.EnchantmentTarget;
import net.minecraft.entity.EquipmentSlot;

public class Soulbound extends Enchantment {

    public Soulbound(Rarity weight, EnchantmentTarget type, EquipmentSlot[] slotTypes) {
        super(weight, type, slotTypes);
    }

    @Override
    public int getMinimumPower(int int_1)
    {
        return 1;
    }

    @Override
    public int getMaximumLevel()
    {
        return 99;
    }
}
