package com.stephenbarrack.crystalCoconut.mixin;

import net.minecraft.advancement.criterion.Criteria;
import net.minecraft.entity.player.PlayerEntity;
import net.minecraft.server.network.ServerPlayerEntity;
import net.minecraft.util.Unit;
import net.minecraft.util.math.BlockPos;
import net.minecraft.server.world.ServerWorld;
import net.minecraft.stat.Stats;

import com.mojang.datafixers.util.Either;

import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfoReturnable;

@Mixin(value = ServerPlayerEntity.class, priority = 5001)
public class NightOwlMixin {

	@Inject(method = "trySleep", at = @At("RETURN"))
	public void tryDaySleep(BlockPos pos, CallbackInfoReturnable<Either<PlayerEntity.SleepFailureReason, Unit>> cb) {
		ServerPlayerEntity player = ((ServerPlayerEntity) (Object) this);
		
		if (cb.getReturnValue().equals(Either.left(PlayerEntity.SleepFailureReason.NOT_POSSIBLE_NOW))) {
			cb.setReturnValue(Either.right(Unit.INSTANCE));
			player.incrementStat(Stats.SLEEP_IN_BED);
			Criteria.SLEPT_IN_BED.trigger(player);
		 	((ServerWorld)player.world).updateSleepingPlayers();
		}
	}
}
