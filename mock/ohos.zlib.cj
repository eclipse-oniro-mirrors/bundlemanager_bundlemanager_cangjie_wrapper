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

package ohos.zlib

import ohos.business_exception.AsyncCallback
import ohos.labels.{APILevel, Hide}
import std.deriving.Derive

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public enum CompressLevel {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    CompressLevelNoCompression
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    CompressLevelBestSpeed
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    CompressLevelBestCompression
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    CompressLevelDefaultCompression
    | ...
}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public enum CompressStrategy {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    CompressStrategyDefaultStrategy
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    CompressStrategyFiltered
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    CompressStrategyHuffmanOnly
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    CompressStrategyRle
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    CompressStrategyFixed
    | ...
}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public enum MemLevel {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    MemLevelMin
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    MemLevelMax
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    MemLevelDefault
    | ...
}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public enum CompressFlushMode {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    NoFlush
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    PartialFlush
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    SyncFlush
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    FullFlush
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    Finish
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    Block
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    Trees
    | ...
}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public enum ReturnStatus {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    Ok
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    StreamEnd
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    NeedDict
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    Errno
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    StreamError
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    DataError
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    MemError
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    BufError
    | ...
}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public enum CompressMethod {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    Deflated
    | ...
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public class Options {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop level: ?CompressLevel {
        get() {
            return None
        }
        set(value) {}
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop memLevel: ?MemLevel {
        get() {
            return None
        }
        set(value) {}
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop strategy: ?CompressStrategy {
        get() {
            return None
        }
        set(value) {}
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public init(
        level!: ?CompressLevel = None,
        memLevel!: ?MemLevel = None,
        strategy!: ?CompressStrategy = None
    ) {
        super()
    }
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public class ZStream {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop nextIn: ?ArrayBuffer {
        get() {
            return None
        }
        set(value) {}
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop availableIn: ?UInt32 {
        get() {
            return None
        }
        set(value) {}
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop totalIn: ?UInt64 {
        get() {
            return None
        }
        set(value) {}
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop nextOut: ?ArrayBuffer {
        get() {
            return None
        }
        set(value) {}
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop availableOut: ?UInt32 {
        get() {
            return None
        }
        set(value) {}
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop totalOut: ?UInt64 {
        get() {
            return None
        }
        set(value) {}
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop dataType: ?Int32 {
        get() {
            return None
        }
        set(value) {}
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop adler: ?UInt64 {
        get() {
            return None
        }
        set(value) {}
    }

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
        super()
    }
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public class ZipOutputInfo {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop status: ReturnStatus {
        get() {
            return ReturnStatus.Ok
        }
        set(value) {}
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop destLen: Int64 {
        get() {
            return 0
        }
        set(value) {}
    }

    public init() {
        super()
    }
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib",
    throwexception: true
]
public func compressFile(inFile: String, outFile: String, options: Options, callback: AsyncCallback<Unit>): Unit {}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib",
    throwexception: true
]
public func compressFiles(inFiles: Array<String>, outFile: String, options: Options,
    callback: AsyncCallback<Unit>): Unit {}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib",
    throwexception: true
]
public func decompressFile(inFile: String, outFile: String, options: Options, callback: AsyncCallback<Unit>): Unit {}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib",
    throwexception: true
]
public func decompressFile(inFile: String, outFile: String, callback: AsyncCallback<Unit>): Unit {}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib",
    throwexception: true
]
public func getOriginalSize(compressedFile: String, callback: AsyncCallback<Int64>): Unit {}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public func createChecksum(callback: AsyncCallback<Checksum>): Unit {}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public func createZip(callback: AsyncCallback<Zip>): Unit {}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public func createGZip(callback: AsyncCallback<GZip>): Unit {}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public class Checksum {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public func crc32(crc: UInt64, buf: ArrayBuffer, callback: AsyncCallback<UInt64>): Unit {}

    public init() {
        super()
    }
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public class Zip {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public func getZStream(callback: AsyncCallback<ZStream>): Unit {}

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func compress(dest: ArrayBuffer, source: ArrayBuffer, callback: AsyncCallback<ZipOutputInfo>,
        sourceLen!: ?Int64 = None): Unit {}

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func compress2(dest: ArrayBuffer, source: ArrayBuffer, level: CompressLevel,
        callback: AsyncCallback<ZipOutputInfo>, sourceLen!: ?Int64 = None): Unit {}

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public func compressBound(sourceLen: Int32, callback: AsyncCallback<Int32>): Unit {}

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func uncompress(dest: ArrayBuffer, source: ArrayBuffer, callback: AsyncCallback<ZipOutputInfo>,
        sourceLen!: ?Int64 = None): Unit {}

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func inflateInit2(strm: ZStream, windowBits: Int32, callback: AsyncCallback<ReturnStatus>): Unit {}

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public func inflateInit(strm: ZStream, callback: AsyncCallback<ReturnStatus>): Unit {}

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func inflateEnd(strm: ZStream, callback: AsyncCallback<ReturnStatus>): Unit {}

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func inflate(strm: ZStream, flush: CompressFlushMode, callback: AsyncCallback<ReturnStatus>): Unit {}

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func deflateInit2(strm: ZStream, level: CompressLevel, method: CompressMethod, windowBits: Int32,
        memLevel: MemLevel, strategy: CompressStrategy, callback: AsyncCallback<ReturnStatus>): Unit {}

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func deflate(strm: ZStream, flush: CompressFlushMode, callback: AsyncCallback<ReturnStatus>): Unit {}

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func deflateEnd(strm: ZStream, callback: AsyncCallback<ReturnStatus>): Unit {}

    public init() {
        super()
    }
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public class GZip {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func gzdopen(fd: Int32, mode: String, callback: AsyncCallback<Unit>): Unit {}

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func gzopen(path: String, mode: String, callback: AsyncCallback<Unit>): Unit {}

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public func gzeof(callback: AsyncCallback<Int32>): Unit {}

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func gzclose(callback: AsyncCallback<ReturnStatus>): Unit {}

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func gzwrite(buf: ArrayBuffer, len: Int64, callback: AsyncCallback<Int64>): Unit {}

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func gzread(buf: ArrayBuffer, callback: AsyncCallback<Int64>): Unit {}

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func gzputs(str: String, callback: AsyncCallback<Int32>): Unit {}

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func gzgets(buf: ArrayBuffer, callback: AsyncCallback<String>): Unit {}

    public init() {
        super()
    }
}
