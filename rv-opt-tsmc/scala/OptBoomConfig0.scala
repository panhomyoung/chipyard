package boom_opt

import chisel3._
import chisel3.util.{log2Up}

import freechips.rocketchip.config.{Parameters, Config, Field}
import freechips.rocketchip.subsystem._
import freechips.rocketchip.devices.tilelink.{BootROMParams}
import freechips.rocketchip.diplomacy.{SynchronousCrossing, AsynchronousCrossing, RationalCrossing}
import freechips.rocketchip.rocket._
import freechips.rocketchip.tile._

import boom.ifu._
import boom.exu._
import boom.lsu._

class WithNOptBoomConfig0(n: Int = 1, overrideIdOffset: Option[Int] = None) extends Config(
  new boom.common.WithTAGELBPD ++ // Default to TAGE-L BPD
  new Config((site, here, up) => {
    case TilesLocated(InSubsystem) => {
      val prev = up(TilesLocated(InSubsystem), site)
      val idOffset = overrideIdOffset.getOrElse(prev.size)
      (0 until n).map { i =>
        boom.common.BoomTileAttachParams(
          tileParams = boom.common.BoomTileParams(
            core = boom.common.BoomCoreParams(
              fetchWidth = 4,
              decodeWidth = 1,
              numRobEntries = 32,
              issueParams = Seq(
                IssueParams(issueWidth=1, numEntries=8, iqType=boom.common.IQT_MEM.litValue, dispatchWidth=1),
                IssueParams(issueWidth=1, numEntries=8, iqType=boom.common.IQT_INT.litValue, dispatchWidth=1),
                IssueParams(issueWidth=1, numEntries=8, iqType=boom.common.IQT_FP.litValue , dispatchWidth=1)),
              numIntPhysRegisters = 52,
              numFpPhysRegisters = 48,
              numLdqEntries = 8,
              numStqEntries = 8,
              maxBrCount = 8,
              numFetchBufferEntries = 8,
              ftq = FtqParameters(nEntries=16),
              nPerfCounters = 2,
              fpu = Some(freechips.rocketchip.tile.FPUParams(sfmaLatency=4, dfmaLatency=4, divSqrt=true))
            ),
            dcache = Some(
              DCacheParams(rowBits = site(SystemBusKey).beatBits, nSets=64, nWays=4, nMSHRs=2, nTLBWays=8)
            ),
            icache = Some(
              ICacheParams(rowBits = site(SystemBusKey).beatBits, nSets=64, nWays=4, fetchBytes=2*4)
            ),
            hartId = i + idOffset
          ),
          crossingParams = RocketCrossingParams()
        )
      } ++ prev
    }
    case SystemBusKey => up(SystemBusKey, site).copy(beatBytes = 8)
    case XLen => 64
  })
)
