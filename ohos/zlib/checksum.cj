/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// The Cangjie API is in Beta. For details on its capabilities and limitations, please refer to the README file.

package ohos.zlib

import ohos.business_exception.AsyncCallback
import ohos.labels.APILevel

class ChecksumImpl {
    let ffiInst_: UIntNative

    init() {
        this.ffiInst_ = unsafe { FfiBundleManagerChecksumInstCreate() }
    }

    ~init() {
        unsafe { FfiBundleManagerChecksumInstDestroy(this.ffiInst_) }
    }

    prop id: UIntNative {
        get() {
            return ffiInst_
        }
    }
}

/**
 * Checksum object.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public class Checksum {
    private var checksumImpl: ChecksumImpl

    init() {
        this.checksumImpl = ChecksumImpl()
    }

    /**
     * Updates a CRC-32 checksum. This API uses an asynchronous callback to return the result.
     *
     * @param { UInt64 } crc - Initial value of the CRC-32 checksum.
     * @param { ArrayBuffer } buf - Data buffer for calculating the checksum.
     * @param { AsyncCallback<UInt64> } callback - Callback used to return the updated CRC-32 checksum.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public func crc32(crc: UInt64, buf: ArrayBuffer, callback: AsyncCallback<UInt64>): Unit {
        spawn {
            var errCode: Int32 = 0
            let vp = unsafe { acquireArrayRawData(buf) }
            let ret = unsafe {
                FfiBundleManagerChecksumCrc32(checksumImpl.id, crc, vp.pointer, UInt64(buf.size), inout errCode)
            }
            unsafe { releaseArrayRawData(vp) }
            callback(Option.None, ret)
        }
    }
}

/**
 * Creates this checksum object. This API uses an asynchronous callback to return the result.
 *
 * @param { AsyncCallback<Checksum> } callback - Callback used to return the created checksum object.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public func createChecksum(callback: AsyncCallback<Checksum>): Unit {
    spawn {
        callback(None, Some(Checksum()))
    }
}
