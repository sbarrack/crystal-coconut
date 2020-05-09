package com.stephenbarrack.crystalCoconut.mixin;

import net.minecraft.client.gui.screen.TitleScreen;
import net.minecraft.server.network.ServerPlayerEntity;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;

@Mixin(value = ServerPlayerEntity.class, priority = 5000)
public class CrystalCoconutMixin {

	@Inject(method = "copyFrom", at = @At("HEAD"))
	private void onRespawn(ServerPlayerEntity player, boolean alive, CallbackInfo ci){
		if(alive){
			System.out.println("The player is about to die!!");
		}
	}
}
