package com.stephenbarrack.crystalCoconut;

import com.stephenbarrack.crystalCoconut.enchantments.Soulbound;

import net.minecraft.item.ItemStack;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import net.fabricmc.api.ModInitializer;
import net.minecraft.enchantment.Enchantment;
import net.minecraft.enchantment.EnchantmentTarget;
import net.minecraft.entity.EquipmentSlot;
import net.minecraft.util.Identifier;
import net.minecraft.util.registry.Registry;

import java.util.Hashtable;
import java.util.UUID;

public class CrystalCoconut implements ModInitializer {
    public static Logger log = LogManager.getLogger();
    public static Hashtable<UUID, Hashtable<Integer, ItemStack>> soulboundInventory;

    @Override
    public void onInitialize() {
        log.info("Initializing soulbound...");

        soulboundInventory = new Hashtable<>();
        Registry.register(Registry.ENCHANTMENT, new Identifier("crystalcoconut", "soulbound"), new Soulbound(Enchantment.Rarity.RARE, EnchantmentTarget.BREAKABLE, EquipmentSlot.values()));
    }
}
