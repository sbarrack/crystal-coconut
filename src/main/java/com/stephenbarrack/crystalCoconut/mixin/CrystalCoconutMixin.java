package com.stephenbarrack.crystalCoconut.mixin;

import net.minecraft.entity.damage.DamageSource;
import net.minecraft.entity.player.PlayerInventory;
import net.minecraft.server.network.ServerPlayerEntity;

import com.stephenbarrack.crystalCoconut.CrystalCoconut;

import net.minecraft.tag.Tag;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;

@Mixin(value = ServerPlayerEntity.class, priority = 5000)
public class CrystalCoconutMixin {

	@Inject(method = "onDeath", at = @At("HEAD"))
	public void _onDeath(DamageSource source, CallbackInfo callbackInfo){
		//Check for enchanted items
		PlayerInventory inventory = ((ServerPlayerEntity) (Object) this).inventory;
		for(int i = 0; i < inventory.size(); i++){
			if(inventory.getStack(i).getTag() != null){
				if(inventory.getStack(i).getTag().get("Enchantments").asString().contains("crystalcoconut:soulbound")){
					//TODO :: DO SOMETHING
				}
			}
		}

	}

	@Inject(method = "copyFrom", at = @At("RETURN"))
	private void onRespawn(ServerPlayerEntity player, boolean alive, CallbackInfo ci){

	}
}
