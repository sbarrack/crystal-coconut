package com.stephenbarrack.crystalCoconut;

import com.stephenbarrack.crystalCoconut.enchantments.Soulbound;
import net.fabricmc.api.ModInitializer;
import net.minecraft.enchantment.Enchantment;
import net.minecraft.enchantment.EnchantmentTarget;
import net.minecraft.entity.EquipmentSlot;
import net.minecraft.util.Identifier;
import net.minecraft.util.registry.Registry;

public class CrystalCoconut implements ModInitializer {

    private static Enchantment SOULBOUND;

    @Override
    public void onInitialize() {
        // This code runs as soon as Minecraft is in a mod-load-ready state.
        // However, some things (like resources) may still be uninitialized.
        // Proceed with mild caution.

        System.out.println("Initalizing Soulbound");
        SOULBOUND = Registry.register(
                Registry.ENCHANTMENT,
                new Identifier("Tweaks", "soulbound"),
                new Soulbound(
                        Enchantment.Rarity.VERY_RARE,
                        EnchantmentTarget.BREAKABLE,
                        EquipmentSlot.values()
                )
        );
    }
}
