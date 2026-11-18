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

class OptionsImpl {
    var level_: ?CompressLevel
    var memLevel_: ?MemLevel
    var strategy_: ?CompressStrategy

    init(
        level!: ?CompressLevel = None,
        memLevel!: ?MemLevel = None,
        strategy!: ?CompressStrategy = None
    ) {
        this.level_ = level
        this.memLevel_ = memLevel
        this.strategy_ = strategy
    }
}

/**
 * Defines options used to compress or decompress a ZIP file.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public class Options {
    private var optionsImpl: OptionsImpl

    /**
     * Compression level specified for compression or decompression.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop level: ?CompressLevel {
        get() {
            return optionsImpl.level_
        }
        set(value) {
            optionsImpl.level_ = value
        }
    }

    /**
     * Memory level specified for compression.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop memLevel: ?MemLevel {
        get() {
            return optionsImpl.memLevel_
        }
        set(value) {
            optionsImpl.memLevel_ = value
        }
    }

    /**
     * Compression strategy specified for compression.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop strategy: ?CompressStrategy {
        get() {
            return optionsImpl.strategy_
        }
        set(value) {
            optionsImpl.strategy_ = value
        }
    }

    /**
     * A constructor used to create an Options.
     *
     * @param { ?CompressLevel } [level] - Compression level specified for compression or decompression.
     * @param { ?MemLevel } [memLevel] - Memory level specified for compression.
     * @param { ?CompressStrategy } [strategy] - Compression strategy specified for compression.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public init(
        level!: ?CompressLevel = None,
        memLevel!: ?MemLevel = None,
        strategy!: ?CompressStrategy = None
    ) {
        this.optionsImpl = OptionsImpl(level: level, memLevel: memLevel, strategy: strategy)
    }
}
