package com.stephenbarrack.crystalCoconut.mixin;

import net.minecraft.entity.damage.DamageSource;
import net.minecraft.entity.player.PlayerInventory;
import net.minecraft.item.ItemStack;
import net.minecraft.server.network.ServerPlayerEntity;

import com.stephenbarrack.crystalCoconut.CrystalCoconut;

import net.minecraft.tag.Tag;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;

import java.util.Enumeration;
import java.util.Hashtable;

@Mixin(value = ServerPlayerEntity.class, priority = 5000)
public class CrystalCoconutMixin {



	@Inject(method = "onDeath", at = @At("INVOKE"))
	public void beforeDeath(DamageSource source, CallbackInfo callbackInfo){
		//Check for enchanted items
		PlayerInventory inventory = ((ServerPlayerEntity) (Object) this).inventory;
		for(int i = 0; i < inventory.size(); i++) {
			if (inventory.getStack(i).getTag() != null) {
				if(inventory.getStack(i).getTag().get("Enchantments") != null) {
					if (inventory.getStack(i).getTag().get("Enchantments").asString().contains("crystalcoconut:soulbound")) {
						CrystalCoconut.soulboundItems.put(i, inventory.getStack(i));
						inventory.removeStack(i);
					}
				}
			}
		}

	}

	@Inject(method = "copyFrom", at = @At("INVOKE"))
	private void onRespawn(ServerPlayerEntity oldPlayer, boolean alive, CallbackInfo ci){
		Enumeration keys = CrystalCoconut.soulboundItems.keys();
		while(keys.hasMoreElements()){
			int i = (int)keys.nextElement();
			oldPlayer.inventory.setStack(i, CrystalCoconut.soulboundItems.get(i));
			((ServerPlayerEntity) (Object) this).inventory.setStack(i, CrystalCoconut.soulboundItems.get(i));
		}
		CrystalCoconut.soulboundItems.clear();
	}
}
