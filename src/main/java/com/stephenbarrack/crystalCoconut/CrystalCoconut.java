package com.stephenbarrack.crystalCoconut;

import com.stephenbarrack.crystalCoconut.enchantments.Soulbound;

import com.stephenbarrack.crystalCoconut.mixin.CrystalCoconutMixin;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import net.fabricmc.api.ModInitializer;
import net.minecraft.enchantment.Enchantment;
import net.minecraft.enchantment.EnchantmentTarget;
import net.minecraft.entity.EquipmentSlot;
import net.minecraft.util.Identifier;
import net.minecraft.util.registry.Registry;

import java.util.Hashtable;

public class CrystalCoconut implements ModInitializer {
    private static Enchantment SOULBOUND;
    public static Logger log = LogManager.getLogger();

    @Override
    public void onInitialize() {
        // System.out.println("Initalizing Soulbound");
        log.info("Initializing soulbound...");
        SOULBOUND = Registry.register(
                Registry.ENCHANTMENT,
                new Identifier("crystalcoconut", "soulbound"),
                new Soulbound(
                    Enchantment.Rarity.VERY_RARE,
                    EnchantmentTarget.BREAKABLE,
                    EquipmentSlot.values()
                )
        );
    }
}
