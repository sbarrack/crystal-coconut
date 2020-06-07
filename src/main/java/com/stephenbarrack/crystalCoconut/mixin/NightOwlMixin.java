package com.stephenbarrack.crystalCoconut.mixin;

import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.ModifyVariable;

import net.minecraft.world.World;

import com.stephenbarrack.crystalCoconut.CrystalCoconut;

@Mixin(value = World.class, priority = 5001)
public class NightOwlMixin {

	// @ModifyVariable(method = "isDay", at = @At("HEAD"), name = "ambientDarkness")
	// public int ambientDarkness(int ad) {
	// 	CrystalCoconut.log.info("Faked ambient darkness of " + ad + "!");
	// 	return 4;
	// }
}
