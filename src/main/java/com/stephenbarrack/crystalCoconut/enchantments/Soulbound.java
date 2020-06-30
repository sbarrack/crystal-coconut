package com.stephenbarrack.crystalCoconut.enchantments;

import net.minecraft.enchantment.Enchantment;
import net.minecraft.enchantment.EnchantmentTarget;
import net.minecraft.entity.EquipmentSlot;
import net.minecraft.text.LiteralText;
import net.minecraft.text.MutableText;
import net.minecraft.text.Text;
import net.minecraft.text.TranslatableText;
import net.minecraft.util.Formatting;

public class Soulbound extends Enchantment {

    public Soulbound(Rarity weight, EnchantmentTarget type, EquipmentSlot[] slotTypes) {
        super(weight, type, slotTypes);
    }

    @Override
    public int getMaxLevel() {
        return 1;
    }

    @Override
    public Text getName(int level) {
        MutableText temp = new TranslatableText(this.getTranslationKey());
        // if there's no Fabric API
        if (temp.getString().equals("enchantment.crystalcoconut.soulbound")) {
            temp = new LiteralText("Blessing of Stasis");
        }
        return temp.formatted(Formatting.GREEN);
    }

    @Override
    protected boolean canAccept(net.minecraft.enchantment.Enchantment other) {
        return !other.isCursed();
    }

    @Override
    public boolean isTreasure() {
        return true;
    }
}
