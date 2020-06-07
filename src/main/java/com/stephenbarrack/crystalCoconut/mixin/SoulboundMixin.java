package com.stephenbarrack.crystalCoconut.mixin;

import net.minecraft.entity.damage.DamageSource;
import net.minecraft.entity.player.PlayerInventory;
import net.minecraft.inventory.EnderChestInventory;
import net.minecraft.server.network.ServerPlayerEntity;

import com.stephenbarrack.crystalCoconut.CrystalCoconut;

import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;

import java.util.Enumeration;
import java.util.Hashtable;

@Mixin(value = ServerPlayerEntity.class, priority = 5000)
public class SoulboundMixin {

	@Inject(method = "onDeath", at = @At("INVOKE"))
	public void beforeDeath(DamageSource source, CallbackInfo callbackInfo) {
		ServerPlayerEntity player = ((ServerPlayerEntity) (Object) this);

		PlayerInventory inventory = player.inventory;
		EnderChestInventory enderChest = player.getEnderChestInventory();

		// if (there is no existing soulbound inventory)
		if (!CrystalCoconut.soulboundInventory.containsKey(player.getUuid())) {
			// make one
			CrystalCoconut.soulboundInventory.put(player.getUuid(), new Hashtable<>());
		}
		
		for (int i = 0; i < inventory.size(); i++) {
			if (inventory.getStack(i).getTag() != null) {
				if (inventory.getStack(i).getTag().get("Enchantments") != null) {
					if (inventory.getStack(i).getTag().get("Enchantments").asString().contains("crystalcoconut:soulbound")) {
						int damage = inventory.getStack(i).getDamage();
						int durability = inventory.getStack(i).getMaxDamage() - damage;

						// if (strong enough to bind to soul)
						if (durability > 100) {
							// bind to soul
							CrystalCoconut.soulboundInventory.get(player.getUuid()).put(i, inventory.getStack(i));
							inventory.removeStack(i);
						} // else if (player's enderchest has room)
						else if (enderChest.canInsert(inventory.getStack(i))) {
							// bind to enderchest
							enderChest.addStack(inventory.getStack(i));
							inventory.removeStack(i);
						}
					}
				}
			}
		}
	}

	@Inject(method = "onDeath", at = @At("RETURN"))
	public void afterDeath(DamageSource source, CallbackInfo callbackInfo) {
		ServerPlayerEntity player = ((ServerPlayerEntity) (Object) this);

		Enumeration<Integer> keys = CrystalCoconut.soulboundInventory.get(player.getUuid()).keys();

		while (keys.hasMoreElements()) {
			int i = (int) keys.nextElement();
			player.inventory.setStack(i, CrystalCoconut.soulboundInventory.get(player.getUuid()).get(i));

			int damage = player.inventory.getStack(i).getDamage();
			int durability = player.inventory.getStack(i).getMaxDamage() - damage;
			if (durability > 100 && !(player.isCreative() || player.isSpectator())) {
				player.inventory.getStack(i).setDamage(damage + 100);
			}

			((ServerPlayerEntity) (Object) this).inventory.setStack(i, CrystalCoconut.soulboundInventory.get(player.getUuid()).get(i));
		}

		CrystalCoconut.soulboundInventory.get(player.getUuid()).clear();
	}

	@Inject(method = "copyFrom", at = @At("INVOKE"))
	private void onRespawn(ServerPlayerEntity oldPlayer, boolean alive, CallbackInfo ci) {
		ServerPlayerEntity player = ((ServerPlayerEntity) (Object) this);
		
		player.inventory.clone(oldPlayer.inventory);
	}
}
