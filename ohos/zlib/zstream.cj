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

import ohos.labels.APILevel

class ZStreamImpl {
    var nextIn_: ?ArrayBuffer
    var availableIn_: ?UInt32
    var totalIn_: ?UInt64
    var nextOut_: ?ArrayBuffer
    var availableOut_: ?UInt32
    var totalOut_: ?UInt64
    var dataType_: ?Int32
    var adler_: ?UInt64

    init(
        nextIn!: ?ArrayBuffer = None,
        availableIn!: ?UInt32 = None,
        totalIn!: ?UInt64 = None,
        nextOut!: ?ArrayBuffer = None,
        availableOut!: ?UInt32 = None,
        totalOut!: ?UInt64 = None,
        dataType!: ?Int32 = None,
        adler!: ?UInt64 = None
    ) {
        this.nextIn_ = nextIn
        this.availableIn_ = availableIn
        this.totalIn_ = totalIn
        this.nextOut_ = nextOut
        this.availableOut_ = availableOut
        this.totalOut_ = totalOut
        this.dataType_ = dataType
        this.adler_ = adler
    }
}

/**
 * Process all the information required for compression and decompression.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public class ZStream {
    private var zstreamImpl: ZStreamImpl

    /**
     * Input bytes to be compressed.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop nextIn: ?ArrayBuffer {
        get() {
            return zstreamImpl.nextIn_
        }
        set(value) {
            zstreamImpl.nextIn_ = value
        }
    }

    /**
     * Number of bytes available for **nextIn**.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop availableIn: ?UInt32 {
        get() {
            return zstreamImpl.availableIn_
        }
        set(value) {
            zstreamImpl.availableIn_ = value
        }
    }

    /**
     * Total number of input bytes read so far.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop totalIn: ?UInt64 {
        get() {
            return zstreamImpl.totalIn_
        }
        set(value) {
            zstreamImpl.totalIn_ = value
        }
    }

    /**
     * Output bytes after compression.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop nextOut: ?ArrayBuffer {
        get() {
            return zstreamImpl.nextOut_
        }
        set(value) {
            zstreamImpl.nextOut_ = value
        }
    }

    /**
     * Number of remaining bytes available for **nextOut**.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop availableOut: ?UInt32 {
        get() {
            return zstreamImpl.availableOut_
        }
        set(value) {
            zstreamImpl.availableOut_ = value
        }
    }

    /**
     * Total number of output bytes.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop totalOut: ?UInt64 {
        get() {
            return zstreamImpl.totalOut_
        }
        set(value) {
            zstreamImpl.totalOut_ = value
        }
    }

    /**
     * Binary or text of **deflate**, or decoding state of **inflate**.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop dataType: ?Int32 {
        get() {
            return zstreamImpl.dataType_
        }
        set(value) {
            zstreamImpl.dataType_ = value
        }
    }

    /**
     * Adler-32 or CRC-32 value of uncompressed data.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop adler: ?UInt64 {
        get() {
            return zstreamImpl.adler_
        }
        set(value) {
            zstreamImpl.adler_ = value
        }
    }

    /**
     * A constructor used to create a ZStream.
     *
     * @param { ?ArrayBuffer } [nextIn] - Input bytes to be compressed.
     * @param { ?UInt32 } [availableIn] - Number of bytes available for **nextIn**.
     * @param { ?UInt64 } [totalIn] - Total number of input bytes read so far.
     * @param { ?ArrayBuffer } [nextOut] - Output bytes after compression.
     * @param { ?UInt32 } [availableOut] - Number of remaining bytes available for **nextOut**.
     * @param { ?UInt64 } [totalOut] - Total number of output bytes.
     * @param { ?Int32 } [dataType] - Binary or text of **deflate**, or decoding state of **inflate**.
     * @param { ?UInt64 } [adler] - Adler-32 or CRC-32 value of uncompressed data.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public init(
        nextIn!: ?ArrayBuffer = None,
        availableIn!: ?UInt32 = None,
        totalIn!: ?UInt64 = None,
        nextOut!: ?ArrayBuffer = None,
        availableOut!: ?UInt32 = None,
        totalOut!: ?UInt64 = None,
        dataType!: ?Int32 = None,
        adler!: ?UInt64 = None
    ) {
        this.zstreamImpl = ZStreamImpl(nextIn: nextIn, availableIn: availableIn, totalIn: totalIn, nextOut: nextOut,
            availableOut: availableOut, totalOut: totalOut, dataType: dataType, adler: adler)
    }

    init(availableIn: UInt32, totalIn: UInt64, availableOut: UInt32, totalOut: UInt64, dataType: Int32,
        adler: UInt64) {
        this.zstreamImpl = ZStreamImpl(availableIn: Some(availableIn), totalIn: Some(totalIn),
            availableOut: Some(availableOut), totalOut: Some(totalOut), dataType: Some(dataType),
            adler: Some(adler))
    }

    static func parse(cStrm: CZStream): ZStream {
        return ZStream(cStrm.availableIn, cStrm.totalIn, cStrm.availableOut, cStrm.totalOut, cStrm.dataType,
            cStrm.adler)
    }

    // Checks that availableIn/availableOut do not exceed the size of the corresponding buffer,
    // and that a set size always has a buffer. Returns false when invalid.
    func checkValid(): Bool {
        if (let Some(len) <- zstreamImpl.availableIn_) {
            if (let Some(v) <- zstreamImpl.nextIn_) {
                if (Int64(len) > v.size) {
                    return false
                }
            } else {
                return false
            }
        }
        if (let Some(len) <- zstreamImpl.availableOut_) {
            if (let Some(v) <- zstreamImpl.nextOut_) {
                if (Int64(len) > v.size) {
                    return false
                }
            } else {
                return false
            }
        }
        return true
    }
}
